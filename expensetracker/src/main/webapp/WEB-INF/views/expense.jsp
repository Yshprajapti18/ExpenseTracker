<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <style>
      h1 {
        text-align: center;
        font-size: 2.5em;
        color: #3498db; /* Blue color for the text */
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2); /* Text shadow for a subtle effect */
        margin-bottom: 30px;
      }
      .expense-form {
        max-width: 400px;
        margin: 0 auto;
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        background-color: #fff;
      }

      /* Style for form input fields */
      .expense-form input[type="text"],
      .expense-form textarea {
        width: 100%;
        padding: 10px;
        margin-bottom: 15px;
        box-sizing: border-box;
        border: 1px solid #ddd;
        border-radius: 4px;
      }

      /* Style for form submit button */
      .expense-form button {
        background-color: #3498db;
        color: #fff;
        padding: 10px 15px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
      }

      /* Hover effect for the submit button */
      .expense-form button:hover {
        background-color: #2980b9;
      }
      a {
        background-color: #3498db;
        color: #fff;
        padding: 10px 15px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
      }
    </style>
    <title>Add Expense</title>
  </head>
  <body>
    <h1>Add Expense</h1>

    <form:form
      class="expense-form"
      action="/expense"
      method="post"
      modelAttribute="expense"
    >
      <form:input path="expensename" placeholder="Enter expense name" />
      <form:input path="amount" placeholder="Enter expense amount" />
      <form:textarea path="note" placeholder="Enter note (optional)" />
      <form:hidden path="id" />

      <button type="submit">Add Expense</button>
      <a href="/expense/${expense.id}/delete">Delete</a>
    </form:form>
  </body>
</html>
