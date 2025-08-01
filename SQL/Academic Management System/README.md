# 🧠 Academic Management System – SQL Procedural Programming

This project models and manages an academic institution’s operations using advanced SQL techniques. It focuses on handling **student enrollments**, **unit eligibility**, **tuition and penalty fees**, and **academic performance tracking** — all enforced via procedural logic to simulate real-world business rules.

---

## 🚀 Project Highlights

- 📌 Built entirely in **SQL (MySQL-compatible)** with robust procedural logic
- 🧮 Implements **stored functions and procedures** for data-driven decisions
- 🛡️ Enforces business rules like fee validation, advanced unit eligibility, and dropped-unit penalties
- 📊 Supports test case-driven validation with extensive sample data

---

## 🧱 Database Structure

The system includes the following relational tables:

- `Student`: Basic student records and active status
- `Unit`: Units offered (with advanced-level flag, capacity, etc.)
- `Registration`: Tracks which students are enrolled in which units (and dropped status)
- `UnitGrade`: Stores student grades, including dropped units
- `Fee`: Records tuition fees, late enrollments, and penalties

---

## ⚙️ Key Features

### 🔧 Stored Function: `CalculateTotalOutstandingBalance`

Calculates a student’s total balance due, including:
- **All unpaid fees** (tuition, late enrollment, penalties)
- **Penalties for late unit drops**:
  - `$600` for advanced units
  - `$400` for non-advanced units

📌 **Used to validate eligibility before unit registration.**

---

### 🔧 Stored Procedure: `RegisterStudentInUnit`

Handles new unit enrollments while enforcing multiple business constraints:

- ❌ **Blocks registration** if any unpaid fees exist
- ❌ **Restricts advanced unit enrollment** if student has failed more than 2 units
- ❌ **Prevents duplicate registrations** in the same unit & semester
- ✅ **Auto-registers** student into a unit when all conditions are satisfied
- ⚠️ **Raises clear error messages** using `SIGNAL` if business rules are violated

---

## 🧪 Test Case Coverage

A comprehensive set of test cases was developed to verify all major outcomes:

| Test Case | Scenario | Outcome |
|-----------|----------|---------|
| TC1 | Student with no debt or failures | ✅ Allowed to enroll |
| TC2 | Student with unpaid tuition | ❌ Blocked (fee rule) |
| TC3 | Student failed 3+ units | ❌ Blocked (advanced rule) |
| TC4 | Already enrolled in unit | ❌ Blocked (duplicate check) |
| TC5 | Student dropped unit late | ✅ Penalty fee calculated correctly |



