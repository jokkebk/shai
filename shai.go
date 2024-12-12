package main

import (
	"context"
	"fmt"
	"os"
	"strings"

	"github.com/openai/openai-go"
	"github.com/openai/openai-go/option"
)

func main() {
	if len(os.Args) < 2 {
		fmt.Println("Usage: shai <natural language description>")
		os.Exit(1)
	}

	// Get API key from environment variable
	apiKey := os.Getenv("OPENAI_API_KEY")
	model := "gpt-4o-mini" // default model

	if apiKey == "" {
		fmt.Println("Please set the OPENAI_API_KEY environment variable")
		os.Exit(1)
	}

	// Combine arguments to form the natural language description
	description := strings.Join(os.Args[1:], " ")

	// Initialize OpenAI client
	client := openai.NewClient(
		option.WithAPIKey(apiKey),
	)

	// Define the system prompt
	systemPrompt := "You are an assistant that converts natural language descriptions of tasks into " +
		"concise, accurate Unix commands. Always output only the Unix command without any " +
		"additional explanations or text. Your response must be a single Unix command."

	// Prepare messages
	messages := openai.F([]openai.ChatCompletionMessageParamUnion{
		openai.SystemMessage(systemPrompt),
		openai.UserMessage(description),
	})

	// Create a chat completion request
	resp, err := client.Chat.Completions.New(
		context.TODO(),
		openai.ChatCompletionNewParams{
			Messages:    messages,
			Model:       openai.F(openai.ChatModel(model)), // use model from config
			Temperature: openai.F(float64(0)),
		},
	)
	if err != nil {
		fmt.Printf("Error calling OpenAI: %v\n", err)
		os.Exit(1)
	}

	if len(resp.Choices) == 0 || resp.Choices[0].Message.Content == "" {
		fmt.Println("No command returned.")
		os.Exit(1)
	}

	// Print the resulting command
	fmt.Println(strings.TrimSpace(resp.Choices[0].Message.Content))
}
