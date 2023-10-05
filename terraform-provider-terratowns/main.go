// "package main": Declares the package name. The "main" package is special in Go, as it's where the execution of the program starts.
package main

// import "fmt": Import the fmt package, which contains functions for formatted I/O.
import (
	//"log"
	"fmt"
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
	"github.com/hashicorp/terraform-plugin-sdk/v2/plugin"
)

// This is the main function. It's the entry point of our application.
func main() {
	plugin.Serve(&plugin.ServeOpts{ 
		ProviderFunc: Provider,
	})
	// Print Line = Println
	fmt.Println("Hello, world!")
}

// In golang, a titlecase function will get exported.
func Provider () *schema.Provider {
	var p *schema.Provider
	p = &schema.Provider{
		ResourcesMap: map[string]*schema.Resource{},
		DataSourcesMap: map[string]*schema.Resource{},
		Schema: map[string]*schema.Schema{
			"endpoint": {
				Type: schema.TypeString,
				Required: true,
				Description: "The endpoint for the external service",
			},
			"token": {
				Type: schema.TypeString,
				Required: true,
				Sensitive: true, 
				Description: "Bearer toklen for authorization",
			},
			"user_uuid": {
				Type: schema.TypeString,
				Required: true,
				Description: "UUID for configuration",
				//ValidateFunc: validateUUID,
			},
		},
	}
	//p.ConfigureContextFunc = providerConfigure(p)
	return p
}

//func validateUUID(v interface{}, k string) (ws []string, errors []error) {
//	log.Print('validateUUID:start')
//	value := v.(string)
//	if _,err = uuid.Parse(value): err != nil {
//		errors = append(error, fmt.Errorf("Invalid UUID format"))
//	}
//	log.Print('validateUUID:end')
//}