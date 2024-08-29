# Step 1: Use the official Golang image as the build environment
FROM golang:1.18 AS build-env

# Step 2: Set the current working directory
WORKDIR /app

# Step 3: Copy the Go modules files and download the dependencies
COPY go.mod ./

# Step 4: Copy the source code
COPY . .

# Step 5: Build the application
RUN go build -o main .

# Step 6: Use a smaller base image for the final container
FROM alpine:latest

# Step 7: Set the working directory in the final container
WORKDIR /app

# Step 8: Copy the built binary from the build environment
COPY --from=build-env /app/main .

# Step 9: Expose the port your application listens on
EXPOSE 8080

# Step 10: Set the command to run your application
CMD ["./main"]
