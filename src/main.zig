const std = @import("std");
const content = @import("./content.zig");

const pages: [3]content.Page = [_]content.Page{
    content.Page{
        .page_type = .{
            .home = .{
                .title = .{
                    .long = "Blog Generator Example",
                    .short = "Blog Example",
                },
                .date = "13 November 2025",
                .description = "An example site",
            },
        },
        .markup = .{ .html = "<h1>Blog site.</h1>" },
    },
    content.Page{
        .page_type = .{
            .post = .{
                .title = .{
                    .long = "Blog Generator Example",
                    .short = "Blog Example",
                },
                .date = "13 November 2025",
                .description = "An example site",
                .is_published = true,
                .post_path = "foo-bar",
            },
        },
        .markup = .{ .file = "./content/foo.html" },
    },
    content.Page{
        .page_type = .{
            .post = .{
                .title = .{
                    .long = "Blog Generator Example",
                    .short = "Blog Example",
                },
                .date = "13 November 2025",
                .description = "An example site",
                .is_published = false,
                .post_path = "biz-baz",
            },
        },
        .markup = .{ .html = "<em>Blog site post.</em>" },
    },
};

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    for (pages) |page| {
        switch (page.page_type) {
            .home => |pg| {
                std.debug.print("Home Page: {s}\n", .{pg.title.long});
            },
            .post => |pg| {
                std.debug.print("Post Page: {s} ({s})\n", .{ pg.title.long, pg.description });
            },
        }
        const html = try page.get_markup(allocator);
        std.debug.print("{s}\n", .{html});
    }
}
