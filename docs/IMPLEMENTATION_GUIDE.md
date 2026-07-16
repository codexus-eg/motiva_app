# Flutter Implementation Guide: Attribute System Refactoring

> **Target Audience:** Flutter Developers
> **Last Updated:** May 2026
> **Prerequisites:** Read `backend/docs/ARCHITECTURE-SERVICES.md` first

---

## Executive Summary

The backend has undergone a major refactoring to separate **vendor-provided attributes** from **customer-provided attributes**. The Flutter app needs to be updated to align with these changes.

### Breaking Changes from Backend

| Old Property | New Property | Location |
|--------------|--------------|----------|
| `attributes` | `categoryServiceAttributes` | VendorService |
| `attributes` | `requiredCustomerFields` | VendorService (new) |
| `orderAttributes` | `orderVendorAttributes` | ServiceOrder |
| `orderAttributes` | `orderCustomerAttributes` | ServiceOrder (new) |
| `requiresDocuments` | `requiresVendorDocuments` | BehaviorConfig |

### What This Means for Flutter

1. **Checkout flow must render dynamic forms** based on `requiredCustomerFields`
2. **Vendor attributes are read-only for customers** — display only, not editable
3. **Order requests must use `orderCustomerAttributes`** instead of `orderAttributes`
4. **Order details must show both vendor snapshot and customer answers**

---

## Part 1: Entity Updates

### 1.1 VendorService Entity

**File:** `lib/features/vendor-services/domain/entities/vendor_service.dart`

**Current State:**
- Has `attributes` property (single Map)
- Missing `requiredCustomerFields`

**Required Changes:**
- Rename `attributes` to `categoryServiceAttributes`
- Add new property `requiredCustomerFields` (list of AttributeField)

**Property Definitions:**

| Property | Type | Description |
|----------|------|-------------|
| `categoryServiceAttributes` | `Map<String, dynamic>` | Static specs filled by vendor (read-only for customer) |
| `requiredCustomerFields` | `List<AttributeField>` | Dynamic form schema for customer checkout |

---

### 1.2 PublicVendorService Entity

**File:** `lib/features/public_services/domain/entities/public_vendor_service.dart`

**Current State:**
- Has `attributes` property
- Missing `requiredCustomerFields`

**Required Changes:**
- Same as VendorService entity above
- Rename `attributes` to `categoryServiceAttributes`
- Add `requiredCustomerFields`

---

### 1.3 CustomerOrder Entity

**File:** `lib/features/customer_orders/domain/entities/customer_order.dart`

**Current State:**
- Has single `orderAttributes` property
- Missing vendor snapshot data

**Required Changes:**
- Add `orderVendorAttributes` (Map<String, dynamic>?) — snapshot of vendor specs
- Add `orderCustomerAttributes` (Map<String, dynamic>?) — customer answers
- Keep `orderAttributes` for backward compatibility during migration, then deprecate

**Property Definitions:**

| Property | Type | Description |
|----------|------|-------------|
| `orderVendorAttributes` | `Map<String, dynamic>?` | Immutable snapshot of vendor's `categoryServiceAttributes` |
| `orderCustomerAttributes` | `Map<String, dynamic>?` | Customer's answers matching `requiredCustomerFields` |

---

### 1.4 VendorOrder Entity

**File:** `lib/features/vendor_orders/domain/entities/vendor_order.dart`

**Required Changes:**
- Same as CustomerOrder entity
- Add `orderVendorAttributes` and `orderCustomerAttributes`

---

### 1.5 BehaviorConfig Entity

**File:** `lib/features/service-categories/domain/entities/service_category.dart`

**Current State:**
- Has `requiresDocuments` property

**Required Changes:**
- Add `requiresVendorDocuments` property
- Deprecate `requiresDocuments` (keep for backward compatibility)

---

### 1.6 CreateOrderDto / CreateOrderRequest

**Files:**
- `lib/features/customer_orders/data/datasources/customer_orders_remote_data_source.dart`
- `lib/features/booking/data/models/create_order_request.dart`

**Current State:**
- Uses `orderAttributes` in JSON payload

**Required Changes:**
- Change property name from `orderAttributes` to `orderCustomerAttributes`
- Update `toJson()` method to send correct key

---

## Part 2: Dynamic Form Builder

### 2.1 Overview

The checkout screen must now render a dynamic form based on the vendor's `requiredCustomerFields`. This is the core change that enables the new attribute system.

### 2.2 Form Field Types

The dynamic form must support the following field types (defined in `AttributeField`):

| Type | Widget | Validation |
|------|--------|------------|
| `text` | TextFormField | Required if `required: true` |
| `number` | TextFormField (keyboardType: number) | Required + min/max range validation |
| `select` | DropdownButton | Required, options from `options` array |
| `boolean` | Switch or Checkbox | Required if `required: true` |
| `file` | File picker + upload | Required if `required: true`, URL string |

### 2.3 AttributeField Structure

Each field in `requiredCustomerFields` contains:

| Property | Type | Description |
|----------|------|-------------|
| `key` | String | Field identifier (used as map key) |
| `label` | String | Display label for the field |
| `type` | String | One of: text, number, select, boolean, file |
| `required` | bool | Whether field is mandatory |
| `options` | List<String>? | Available options for select type |
| `min` | num? | Minimum value for number type |
| `max` | num? | Maximum value for number type |

### 2.4 Form Builder Widget

**Create New File:** `lib/shared/widgets/dynamic_form/dynamic_form_builder.dart`

**Purpose:** A reusable widget that takes `List<AttributeField>` schema and produces a form with validation.

**Widget Interface:**
- Input: `List<AttributeField> fields`
- Input: `Map<String, dynamic> initialValues` (for editing existing orders)
- Output: `Map<String, dynamic> values` (via callback or form key)

**Required Functionality:**
- Parse field schema
- Build appropriate widget for each type
- Collect values into a map keyed by `field.key`
- Validate required fields
- Validate number ranges (min/max)
- Validate select options
- Support file upload for `file` type fields

---

## Part 3: Booking Screen Updates

**File:** `lib/features/booking/presentation/screens/booking_screen.dart`

### 3.1 Current Issues

1. Uses `widget.service.attributes` which should be `categoryServiceAttributes`
2. Displays vendor attributes as if they were customer inputs
3. No dynamic form generation from `requiredCustomerFields`
4. Sends `orderAttributes` instead of `orderCustomerAttributes`

### 3.2 Required Changes

#### A. Update Initialization

In `_initializeBooking()` method:
- Use `categoryServiceAttributes` instead of `attributes`
- Store `requiredCustomerFields` in booking state

#### B. Replace Vendor Attributes Section

Current `_buildVendorAttributesSection()` displays vendor attributes as if they are customer inputs.

**New Behavior:**
- Rename section to "Service Specifications" or "Vendor Details"
- Display `categoryServiceAttributes` as READ-ONLY information
- These are what the vendor has configured (tint percentage, warranty, etc.)
- Show as a simple key-value display, not editable fields

#### C. Add Dynamic Customer Form Section

Create new section: `_buildCustomerFieldsSection()`

**Behavior:**
- Render AFTER vendor attributes section
- Use `DynamicFormBuilder` widget
- Use `widget.service.requiredCustomerFields` as schema
- Collect customer answers
- Pass to booking state as `orderCustomerAttributes`

#### D. Update State Management

**BookingState Entity:**
- Add `requiredCustomerFields` property (List<AttributeField>)
- Rename `orderAttributes` to `orderCustomerAttributes`
- Keep `categoryServiceAttributes` for display purposes

#### E. Update Order Submission

**CreateOrderRequest:**
- Change JSON key from `orderAttributes` to `orderCustomerAttributes`
- Submit only customer answers, not vendor attributes

---

## Part 4: Order Details Screen Updates

**File:** `lib/features/customer_orders/presentation/screens/order_details_screen.dart`

### 4.1 Current Issues

1. Only displays `orderAttributes`
2. Cannot distinguish between vendor specs and customer answers

### 4.2 Required Changes

#### A. Add Vendor Attributes Card

Create `_buildVendorAttributesCard()`:
- Display `orderVendorAttributes` (vendor's snapshot)
- Label as "Service Specifications" or "What You Ordered"
- Read-only display

#### B. Add Customer Attributes Card

Create `_buildCustomerAttributesCard()`:
- Display `orderCustomerAttributes` (customer's answers)
- Label as "Your Information" or "Your Details"
- Read-only display of what customer submitted

#### C. Update Model Parsing

**CustomerOrderModel:**
- Parse `orderVendorAttributes` from JSON
- Parse `orderCustomerAttributes` from JSON
- Keep `orderAttributes` for backward compatibility

---

## Part 5: Vendor Order Details Updates

**Files:**
- `lib/features/vendor_orders/domain/entities/vendor_order.dart`
- `lib/features/vendor_orders/presentation/screens/` (order details screens)

### 5.1 Required Changes

#### A. Update Entity

Same as CustomerOrder:
- Add `orderVendorAttributes`
- Add `orderCustomerAttributes`

#### B. Update Order Details UI

Display both attribute types so vendor can see:
1. What specs they promised (vendor attributes)
2. What the customer answered (customer attributes)

---

## Part 6: Vendor Document Upload

### 6.1 Overview

When a service category has `requiresVendorDocuments: true`, vendors must upload completion documents before marking an order as complete.

### 6.2 Required Implementation

#### A. Document Upload Flow

**Trigger:** When vendor attempts to complete an order

**Check:** If category has `requiresVendorDocuments: true`

**Requirement:** At least one document in `service_order_documents` table

#### B. Complete Order Flow Update

**File:** `lib/features/vendor_orders/presentation/widgets/dialogs/complete_order_dialog.dart`

**New Behavior:**
1. Before showing complete dialog, check if documents are required
2. If required and no documents uploaded, show upload prompt
3. Add document upload section to complete order dialog
4. Upload documents via `POST /api/service-order-documents`

#### C. Service Order Documents Feature

**Create New Files:**
- `lib/features/service_order_documents/domain/entities/service_order_document.dart`
- `lib/features/service_order_documents/data/datasources/service_order_documents_remote_data_source.dart`
- `lib/features/service_order_documents/presentation/providers/` 

**Entity Structure:**

| Property | Type | Description |
|----------|------|-------------|
| `id` | String | Document UUID |
| `serviceOrderId` | String | Related order ID |
| `documentType` | String | Type description |
| `fileUrl` | String | S3 URL |
| `originalFilename` | String | Original file name |
| `createdAt` | DateTime | Upload timestamp |

---

## Part 7: Vendor Service Creation Flow

### 7.1 Overview

When vendors create a new service, they must:
1. Fill the category's `attributeSchema` (vendor attributes)
2. Define `requiredCustomerFields` (customer checkout form)

### 7.2 Create Service Screen Updates

**File:** `lib/features/vendor-services/presentation/screens/create_service_screen.dart`

#### A. Vendor Attributes Section

**Data Source:** `category.attributeSchema` from the selected category

**Behavior:**
- Render form based on category's attribute schema
- Collect values as `categoryServiceAttributes`
- Validate required fields

#### B. Customer Fields Definition Section (NEW)

**Purpose:** Let vendor define what customers must answer during checkout

**UI Components:**
- "Add Customer Question" button
- Field type selector (text, number, select, boolean, file)
- Label input
- Required toggle
- For select type: options input (comma-separated or tag input)
- For number type: min/max inputs

**Output:** `List<AttributeField> requiredCustomerFields`

---

## Part 8: Data Flow Diagrams

### 8.1 Customer Checkout Flow

```
Customer taps "Book Service"
        │
        ▼
┌───────────────────────────────┐
│   BookingScreen loads         │
│   vendorService data          │
└───────────────────────────────┘
        │
        ▼
┌───────────────────────────────┐
│ Display Service Summary       │
│ (name, price, vendor info)    │
└───────────────────────────────┘
        │
        ▼
┌───────────────────────────────┐
│ Display Vendor Attributes     │
│ (categoryServiceAttributes)   │
│ READ-ONLY                     │
│ Example: Tint: 35%,           │
│          Warranty: 12 months  │
└───────────────────────────────┘
        │
        ▼
┌───────────────────────────────┐
│ Render Dynamic Customer Form  │
│ (requiredCustomerFields)      │
│ Example:                      │
│  - Vehicle Photo [FILE]       │
│  - Insurance Type [SELECT]    │
│  - Civil ID [FILE]            │
└───────────────────────────────┘
        │
        ▼
┌───────────────────────────────┐
│ Location/Route Section        │
│ (based on behaviorConfig)     │
└───────────────────────────────┘
        │
        ▼
┌───────────────────────────────┐
│ Scheduling Section            │
│ (if allowsScheduling: true)   │
└───────────────────────────────┘
        │
        ▼
┌───────────────────────────────┐
│ Submit Order                  │
│ POST /api/service-orders      │
│ {                             │
│   vendorServiceId,            │
│   orderCustomerAttributes,    │
│   locationLat, locationLng,   │
│   scheduledAt                 │
│ }                             │
└───────────────────────────────┘
        │
        ▼
┌───────────────────────────────┐
│ Order Created                 │
│ Backend creates snapshot:     │
│ - orderVendorAttributes       │
│ - orderCustomerAttributes     │
└───────────────────────────────┘
```

### 8.2 Order Details Display Flow

```
User opens Order Details Screen
        │
        ▼
┌───────────────────────────────┐
│ Fetch order from API          │
│ GET /api/service-orders/:id   │
└───────────────────────────────┘
        │
        ▼
┌───────────────────────────────┐
│ Display Order Status Banner   │
│ (pending, accepted, etc.)     │
└───────────────────────────────┘
        │
        ▼
┌───────────────────────────────┐
│ Display Order Info Card       │
│ (ref, service, vendor, price) │
└───────────────────────────────┘
        │
        ▼
┌───────────────────────────────┐
│ Display Vendor Snapshot Card  │
│ (orderVendorAttributes)       │
│ "What the vendor promised"    │
│ Example:                      │
│  Tint: 35%                    │
│  Coverage: Full Body          │
│  Warranty: 12 months          │
└───────────────────────────────┘
        │
        ▼
┌───────────────────────────────┐
│ Display Customer Answers Card │
│ (orderCustomerAttributes)     │
│ "Your submitted information"  │
│ Example:                      │
│  Vehicle Photo: [image]       │
│  Insurance Type: Comprehensive│
│  Civil ID: [image]            │
└───────────────────────────────┘
        │
        ▼
┌───────────────────────────────┐
│ Display Location/Timeline     │
│ (existing cards)              │
└───────────────────────────────┘
```

---

## Part 9: Implementation Checklist

### Phase 1: Entity Updates (Required)

| Task | Priority | Files Affected |
|------|----------|----------------|
| Update VendorService entity | HIGH | vendor_service.dart |
| Update PublicVendorService entity | HIGH | public_vendor_service.dart |
| Update CustomerOrder entity | HIGH | customer_order.dart |
| Update CustomerOrderModel | HIGH | customer_order_model.dart |
| Update VendorOrder entity | HIGH | vendor_order.dart |
| Update BehaviorConfig | MEDIUM | service_category.dart |
| Update CreateOrderDto | HIGH | create_order_request.dart |
| Update CreateOrderRequest | HIGH | customer_orders_remote_data_source.dart |

### Phase 2: Booking Screen Updates (Required)

| Task | Priority | Files Affected |
|------|----------|----------------|
| Create DynamicFormBuilder widget | HIGH | NEW FILE |
| Update booking_screen.dart | HIGH | booking_screen.dart |
| Update BookingState entity | HIGH | booking_state.dart |
| Add customer fields section | HIGH | booking_screen.dart |
| Fix vendor attributes display | HIGH | booking_screen.dart |

### Phase 3: Order Details Updates (Required)

| Task | Priority | Files Affected |
|------|----------|----------------|
| Update order_details_screen.dart | HIGH | order_details_screen.dart |
| Add vendor attributes card | HIGH | order_details_screen.dart |
| Add customer attributes card | HIGH | order_details_screen.dart |

### Phase 4: Vendor Features (Required for Vendors)

| Task | Priority | Files Affected |
|------|----------|----------------|
| Update create_service_screen.dart | MEDIUM | create_service_screen.dart |
| Add customer fields definition UI | MEDIUM | create_service_screen.dart |
| Update vendor order details | MEDIUM | vendor order screens |

### Phase 5: Document Upload (Required for Exam/Insurance)

| Task | Priority | Files Affected |
|------|----------|----------------|
| Create service_order_documents feature | MEDIUM | NEW FEATURE |
| Update complete_order_dialog.dart | MEDIUM | complete_order_dialog.dart |
| Add document upload UI | MEDIUM | vendor order screens |

---

## Part 10: API Contract Reference

### 10.1 GET /api/vendor-services/:id

**Response includes:**

```json
{
  "id": "uuid",
  "name": "Window Tinting",
  "basePrice": "800.000",
  "categoryServiceAttributes": {
    "tint_percentage": 35,
    "coverage_area": "full_body",
    "warranty_months": 12
  },
  "requiredCustomerFields": [
    {
      "key": "vehicle_photo",
      "label": "Vehicle Photo",
      "type": "file",
      "required": true
    },
    {
      "key": "insurance_type",
      "label": "Insurance Type",
      "type": "select",
      "required": true,
      "options": ["comprehensive", "third_party", "theft_fire"]
    }
  ]
}
```

### 10.2 POST /api/service-orders

**Request body:**

```json
{
  "vendorServiceId": "uuid",
  "orderCustomerAttributes": {
    "vehicle_photo": "https://s3.com/vehicle.jpg",
    "insurance_type": "comprehensive"
  },
  "locationLat": 30.0444,
  "locationLng": 31.2357,
  "locationAddress": "123 Street Name",
  "scheduledAt": "2026-05-01T10:00:00Z"
}
```

**Response includes:**

```json
{
  "id": "uuid",
  "orderRef": "ORD-2026-ABC123",
  "status": "accepted",
  "orderVendorAttributes": {
    "tint_percentage": 35,
    "coverage_area": "full_body"
  },
  "orderCustomerAttributes": {
    "vehicle_photo": "https://s3.com/vehicle.jpg",
    "insurance_type": "comprehensive"
  }
}
```

### 10.3 GET /api/service-orders/:id

**Response includes both attribute snapshots:**

```json
{
  "id": "uuid",
  "orderRef": "ORD-2026-ABC123",
  "status": "completed",
  "baseAmount": "800.000",
  "totalAmount": "800.000",
  "orderVendorAttributes": {
    "tint_percentage": 35,
    "warranty_months": 12
  },
  "orderCustomerAttributes": {
    "vehicle_photo": "https://s3.com/vehicle.jpg",
    "insurance_type": "comprehensive"
  },
  "createdAt": "2026-05-01T08:00:00Z",
  "completedAt": "2026-05-01T12:00:00Z"
}
```

---

## Part 11: Testing Checklist

### Unit Tests

- [ ] VendorService entity parses `categoryServiceAttributes` and `requiredCustomerFields`
- [ ] CustomerOrder entity parses `orderVendorAttributes` and `orderCustomerAttributes`
- [ ] CreateOrderRequest produces correct JSON with `orderCustomerAttributes`
- [ ] DynamicFormBuilder validates all field types correctly

### Widget Tests

- [ ] DynamicFormBuilder renders all field types
- [ ] DynamicFormBuilder shows validation errors
- [ ] Booking screen displays vendor attributes (read-only)
- [ ] Booking screen displays dynamic customer form
- [ ] Order details displays both attribute types

### Integration Tests

- [ ] Complete checkout flow with dynamic form
- [ ] File upload in dynamic form
- [ ] Order creation with correct payload
- [ ] Order details display both attribute snapshots

---

## Part 12: Migration Strategy

### Step 1: Add New Properties (Non-Breaking)

1. Update all entities to include both old and new properties
2. Add `orderCustomerAttributes` alongside existing `orderAttributes`
3. Parse both from API response

### Step 2: Update Create Order Flow

1. Build dynamic form from `requiredCustomerFields`
2. Submit to `orderCustomerAttributes` endpoint key
3. Keep fallback for compatibility

### Step 3: Update Display Screens

1. Update order details to show both attribute types
2. Remove old `orderAttributes` display

### Step 4: Deprecate Old Properties

1. Mark `orderAttributes` as deprecated
2. Mark `attributes` (single) as deprecated
3. Remove in next major version

---

## Appendix A: File Upload for Customer Attributes

For `file` type fields in `requiredCustomerFields`:

1. Use `image_picker` or `file_picker` package
2. Upload file via `POST /api/upload/presigned-url` to get S3 URL
3. Store the returned URL as the field value in `orderCustomerAttributes`

Example flow:
- Customer taps "Upload Vehicle Photo"
- File picker opens
- Customer selects image
- App uploads to S3 via presigned URL
- App receives URL: `https://s3.com/vehicle_123.jpg`
- App stores in form: `{"vehicle_photo": "https://s3.com/vehicle_123.jpg"}`

---

## Appendix B: Error Handling

### Validation Errors from Backend

The backend validates `orderCustomerAttributes` against `requiredCustomerFields`. Possible errors:

| Error | Cause | Fix |
|-------|-------|-----|
| "Missing required attribute: Vehicle Photo" | Required field not provided | Show validation error on field |
| "Unknown attribute: foo" | Extra field not in schema | Remove extra field from payload |
| "Insurance Type has invalid value" | Select option not in allowed list | Show valid options to user |
| "Car Year must be at least 2000" | Number below min constraint | Show constraint error |

### Form Validation

Build client-side validation matching backend:
- Check required fields have values
- Check select values are in options list
- Check numbers are within min/max bounds
- Check file fields have valid URLs

---

## Contact for Questions

- **Architecture Questions:** Refer to `backend/docs/ARCHITECTURE-SERVICES.md`
- **API Contract Questions:** Check `backend/openapi.json`
- **Implementation Issues:** Contact backend team lead