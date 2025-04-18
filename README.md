# 🧑‍💼 Employee Management System (EMS) - README

## 🚀 Project Overview
Welcome to the **Employee Management System (EMS)**! This SQL-based project helps you manage employee data, departments, job titles, attendance, salaries, and projects efficiently. Perfect for organizations wanting to keep track of their workforce and projects with ease.

---

## ✨ Features

- 🏢 **Department & Job Management**: Organize employees by departments and job titles.
- 👥 **Employee Records**: Store detailed employee info including manager relationships.
- 📅 **Attendance Tracking**: Record daily attendance status (Present, Absent, Leave).
- 💰 **Salary Management**: Manage base salary, bonuses, deductions, and payment dates.
- 📊 **Project Allocation**: Assign employees to projects with start/end dates and roles.
- 🔍 **Powerful Queries**: Retrieve employee lists, counts, salaries, project info, and more.
- 🧮 **User-Defined Functions**: Calculate employee age and birthdays by month.

---

## 🗂️ Database Schema

| Table Name         | Description                                      |
|--------------------|------------------------------------------------|
| Department         | Department IDs and names                         |
| JobTitle           | Job titles with unique IDs                       |
| Employee           | Employee details, including manager references  |
| Attendance         | Daily attendance records                         |
| Salary             | Salary details (base, bonus, deductions)        |
| Project            | Projects and their managers                      |
| ProjectAllocation  | Employee assignments to projects                 |

---

## ⚙️ Setup Instructions

1. **Create Database & Tables**  
   Run `Schema_and_Data.sql` to create the EMS database, tables, and insert sample data.

2. **Populate Sample Data**  
   The script inserts departments, job titles, employees, attendance, salary, and projects.

3. **Execute Queries**  
   Use `QnA.sql` for example queries to explore employee info, project assignments, salaries, and more.

---

## 🔍 Sample Queries Highlights

- 👤 List all employee names.
- 💻 Find employees with the job title "Software Engineer".
- 📅 Show the last 7 hired employees.
- 📊 Count employees by job title or department.
- 🏢 Get full info of employees in the "Engineering" department.
- 🎯 List employees and their projects with roles.
- 🎂 Find employees with birthdays in a specific month and calculate their age.
- 👨‍💼 Identify managers with the most employees.

---

## 🛠️ Example Function: Birthday Finder

```sql
CREATE FUNCTION fn_GetBirthday(@Month INT)
RETURNS TABLE
AS
RETURN
SELECT FirstName, LastName, DateOfBirth,
       YEAR(GETDATE()) - YEAR(DateOfBirth) AS Age
FROM Employee
WHERE MONTH(DateOfBirth) = @Month;
```

Use this to find employees celebrating birthdays in a given month 🎉.

---

## 📈 Future Enhancements

- Calculate years of service per department.
- Add detailed leave management.
- Automate payroll with stored procedures.
- Integrate with a front-end dashboard for live updates.

---

## 📞 Contact

For questions or contributions, please reach out to the project maintainer.

---

This README provides a clear, emoji-enhanced guide to your EMS project, making it easy and fun to understand and use! 🎉📊👩‍💻

---

*All SQL scripts and data are included in the attached files: `Schema_and_Data.sql` and `QnA.sql`.*

