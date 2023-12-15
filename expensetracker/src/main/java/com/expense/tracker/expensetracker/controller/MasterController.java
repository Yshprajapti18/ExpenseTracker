package com.expense.tracker.expensetracker.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.web.servlet.ModelAndView;

import java.util.List;

import com.expense.tracker.expensetracker.model.Expense;
import com.expense.tracker.expensetracker.service.ExpenseService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller

public class MasterController {

    @Autowired
    ExpenseService expenseService;

    @RequestMapping("/expense")
    public ModelAndView addExpense(HttpServletRequest request, HttpSession session) {
        ModelAndView mav = new ModelAndView("expense");
        String budget = request.getParameter("budget");
        session.setAttribute("budget", budget);
        mav.addObject("budget", budget);
        mav.addObject("expense", new Expense());
        return mav;
    }

    @RequestMapping(value = "/expense", method = RequestMethod.POST)
    public String save(@ModelAttribute("expense") Expense expense, HttpServletRequest request, HttpSession session) {

        String budget = request.getParameter("budget");
        session.setAttribute("budget", budget);
        expenseService.save(expense);
        return "redirect:/";
    }

    @RequestMapping(value = "/", method = RequestMethod.POST)
    public ModelAndView setBudget(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("home");
        List<Expense> expenses = expenseService.findAll();

        mav.addObject("budget", request.getParameter("budget"));
        mav.addObject("expenses", expenses);
        return mav;
    }

    @RequestMapping("/")
    public ModelAndView home(HttpServletRequest request, HttpSession session) {
        ModelAndView mav = new ModelAndView("home");
        Integer budget;
        if (request.getParameter("budget") == null) {
            // Check the session for the budget attribute
            budget = (Integer) session.getAttribute("budget");
            if (budget == null) {
                budget = 100000;
            }
        } else {
            budget = Integer.parseInt(request.getParameter("budget"));
            // Store the budget attribute in the session
            session.setAttribute("budget", budget);
        }
        List<Expense> expenses = expenseService.findAll();
        mav.addObject("message", "hello world");
        mav.addObject("budget", budget);
        mav.addObject("expenses", expenses);

        return mav;
    }

    @RequestMapping(value = "/expense/{id}")
    public ModelAndView edit(@PathVariable("id") Long id) {
        ModelAndView mav = new ModelAndView("expense");
        Expense expense = expenseService.findById(id);
        mav.addObject("expense", expense);
        return mav;
    }

    @RequestMapping(value = "/expense/{id}/delete")
    public String delete(@PathVariable("id") Long id) {
        expenseService.delete(id);
        return "redirect:/";
    }

    @GetMapping("/expense-chart")
    public ModelAndView expenseChart() {
        List<Expense> expenses = expenseService.findAll();
        ModelAndView mav = new ModelAndView("expense-chart");
        mav.addObject("expenses", expenses);
        return mav;
    }

}
