<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en" xmlns:th="http://www.thymeleaf.org">
  <head>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <style>
      .notification {
        padding: 15px;
        margin-bottom: 15px;
        border: 1px solid #ccc;
        color: #333;
        position: relative;
      }

      .warning {
        background-color: #ffdddd;
        border-color: #ff9999;
        color: #990000;
      }

      .fancy {
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        transition: background-color 0.3s ease;
      }

      .fancy:hover {
        background-color: #ffeeee;
      }

      .icon {
        font-size: 20px;
        margin-right: 10px;
        color: #ff6347; /* Tomato color for the exclamation mark */
      }

      a.add-expense-link {
        display: inline-block;
        padding: 10px 20px;
        font-size: 16px;
        text-decoration: none;
        background-color: #4caf50;
        color: white;
        border-radius: 5px;
        transition: background-color 0.3s;
      }

      /* Hover effect for the link */
      a.add-expense-link:hover {
        background-color: #45a049;
      }

      /* Style for the entire table */
      table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
      }

      /* Style for table header */
      th {
        background-color: #3498db; /* Header background color */
        color: white; /* Header text color */
        padding: 10px;
      }

      /* Style for table rows */
      tr:nth-child(even) {
        background-color: #f2f2f2; /* Even row background color */
      }

      /* Style for table cells */
      td,
      th {
        border: 1px solid #dddddd;
        text-align: left;
        padding: 8px;
      }

      /* Style for expense name */
      td:first-child {
        font-size: 18px;
        font-weight: bold;
      }

      /* Style for amount */
      td:nth-child(2) {
        font-weight: bold;
        color: #27ae60; /* Green color for amount */
      }

      /* Style for Edit link */
      td:last-child a {
        text-decoration: none;
        padding: 5px 10px;
        background-color: #e74c3c; /* Red background color for Edit link */
        color: white;
        border-radius: 3px;
        transition: background-color 0.3s;
      }

      /* Hover effect for Edit link */
      td:last-child a:hover {
        background-color: #c0392b; /* Darker red on hover */
      }

      h1 {
        text-align: center;
        font-size: 2.5em;
        color: #3498db; /* Blue color for the text */
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2); /* Text shadow for a subtle effect */
        margin-bottom: 30px;
      }
    </style>
    <title>Expense Tracker</title>
  </head>
  <body>
    <h1>Expense Tracker</h1>

    <form action="/" method="post" modelAttribute="budget">
      <label for="budget">Enter Budget Limit:</label>
      <input type="number" id="budget" name="budget" />
      <button type="submit">Set Budget Limit</button>
      <input type="hidden" id="budget" name="budget" value="${budget}" />
    </form>

    <a href="/expense" class="add-expense-link">Add expense</a>
    <h2>Your budget limit is ${budget}</h2>

    <table border="1">
      <thead>
        <tr>
          <th>Expense Name</th>
          <th>Amount</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <c:set var="total" scope="session" value="0" />
        <c:forEach var="expense" items="${expenses}">
          <tr>
            <td><h3>${expense.expensename}</h3></td>
            <td>&#8377;${expense.amount}</td>
            <c:set
              var="total"
              scope="session"
              value="${total + expense.amount}"
            />
            <td><a href="/expense/${expense.id}">Edit</a></td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
    <p>Total Expenses: &#8377;${total}</p>
    <c:choose>
      <c:when test="${total > budget}">
        <div class="notification fancy warning">
          <span class="icon">&#9888;</span> Budget Limit Exceeded!
        </div>
      </c:when>
      <c:otherwise>
        <!-- No notification if within the budget limit -->
      </c:otherwise>
    </c:choose>
    <canvas id="expenseChart" width="400" height="200"></canvas>
    <c:set var="expenseLabels" value="" />
    <c:set var="expenseAmounts" value="" />

    <c:forEach var="expense" items="${expenses}">
      <c:set
        var="expenseLabels"
        value="${expenseLabels},'${expense.expensename}'"
      />
      <c:set var="expenseAmounts" value="${expenseAmounts},${expense.amount}" />
    </c:forEach>
    <script>
      var expenseLabels = [${expenseLablels.substring(1)}];
      var expenseAmounts = [${expenseAmounts.substring(1)}];

      var ctx = document.getElementById('expenseChart').getContext('2d');
      var expenseChart = new Chart(ctx, {
         type: 'bar',
         data: {
            labels: expenseLabels,
            datasets: [{
               label: 'Expense Amount',
               data: expenseAmounts,
               backgroundColor: 'rgba(75, 192, 192, 0.2)',
               borderColor: 'rgba(75, 192, 192, 1)',
               borderWidth: 1
            }]
         },
         options: {
            scales: {
               y: {
                  beginAtZero: true
               }
            }
         }
      });
    </script>
  </body>
</html>
