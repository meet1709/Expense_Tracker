package com.meet.personalExpense.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class Budget {
    @Id
    private int month;
    private double budget;

    public Budget(int month, double budget) {
        this.month = month;
        this.budget = budget;
    }

    public Budget() {}

    public int getMonth() {
        return month;
    }

    public void setMonth(int month) {
        this.month = month;
    }

    public double getBudget() {
        return budget;
    }

    public void setBudget(double budget) {
        this.budget = budget;
    }
}
