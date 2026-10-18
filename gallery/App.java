package com.syntax.gallery;

import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.stream.Collectors;

public final class App {
    public record Task(long id, String description, boolean completed) {}

    public static CompletableFuture<List<String>> getActiveTaskDescriptions(List<Task> tasks) {
        return CompletableFuture.supplyAsync(() ->
            tasks.stream()
                .filter(t -> !t.completed())
                .map(Task::description)
                .map(String::toUpperCase)
                .collect(Collectors.toList())
        );
    }

    public static void main(String[] args) {
        var tasks = List.of(
            new Task(1L, "Write syntax highlighter", true),
            new Task(2L, "Generate gallery test suite", false)
        );

        getActiveTaskDescriptions(tasks).thenAccept(list -> {
            System.out.println("Active tasks: " + list);
        }).join();
    }
}
