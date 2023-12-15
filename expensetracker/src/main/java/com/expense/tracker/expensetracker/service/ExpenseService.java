package com.expense.tracker.expensetracker.service;

import java.util.List;

import com.expense.tracker.expensetracker.model.Expense;

public interface ExpenseService {
    List<Expense> findAll();

    void save(Expense save);

    Expense findById(Long id);

    void delete(Long id);
}
