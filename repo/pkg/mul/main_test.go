package mul

import (
	"fmt"
	"testing"
)

func TestSolution(t *testing.T) {
	var tests = []struct {
		a    int
		want int
	}{
		{2, 8},
		{4, 16},
	}

	for _, tt := range tests {

		testname := fmt.Sprintf("%d", tt.want)
		t.Run(testname, func(t *testing.T) {
			ans := Solution(tt.a)
			if ans != tt.want {
				t.Errorf("got %d, want %d", ans, tt.want)
			}
		})
	}
}
