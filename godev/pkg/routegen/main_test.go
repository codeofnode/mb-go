package routegen

import (
	"fmt"
	"testing"
)

func Test(t *testing.T) {
	var tests = []struct {
		a    []string
		want string
	}{
		{[]string{"a"}, "a starting ..."},
	}

	for _, tt := range tests {

		testname := fmt.Sprintf("%s", tt.want)
		t.Run(testname, func(t *testing.T) {
			ans := Init(tt.a)
			if ans != tt.want {
				t.Errorf("got %s, want %s", ans, tt.want)
			}
		})
	}
}
