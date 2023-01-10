using Microsoft.Extensions.Primitives;

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/", (HttpRequest request) =>
{
  request.Query.TryGetValue("len", out StringValues len);
  return $"NCC-{RegistryNumberHelper.generateNumber(len)}{RegistryNumberHelper.generateSuffix()}";
});

app.Run();
