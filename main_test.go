package main

import (
	"testing"
)

func TestCalc(t *testing.T) {
	t.Run("Failure responses", func(t *testing.T) {
		got := calc(2, 2)

		if got == 4 {
			t.Errorf("calc(2, 2) = %d, want 6", got)
		}
	})
}
