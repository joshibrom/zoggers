const std = @import("std");
const content = @import("./content.zig");

const posts: [2]content.Post = [_]content.Post{
    content.Post{
        .title = .{ .long = "Some long title", .short = "A title" },
        .description = "Desc",
        .date = "11-12-25",
        .is_published = true,
        .markup = .{ .file = "content/foo.html" },
    },
    content.Post{
        .title = .{ .long = "Another title", .short = "Another title" },
        .description = "Desc",
        .date = "11-12-25",
        .is_published = false,
        .markup = .{ .html = "<em>Some content</em>" },
    },
};

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    for (posts) |p| {
        std.debug.print("{s}\n", .{try p.get_markup(allocator)});
    }
}
