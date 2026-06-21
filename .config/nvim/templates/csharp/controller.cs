using Microsoft.AspNetCore.Mvc;

namespace {{_namespace_}};

[ApiController]
[Route("api/[controller]")]
public class {{_file_name_}}(ILogger<{{_file_name_}}> logger) : ControllerBase
{
    {{_cursor_}}
}
