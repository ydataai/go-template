package main

import (
	"testing"
)

func TestCalc(t *testing.T) {
	got := calc(2, 2)

	if got != 4 {
		t.Errorf("calc(2, 2) = %d, want 4", got)
	}
}
