using Microsoft.Extensions.Primitives;

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();
var port = Environment.GetEnvironmentVariable("PORT") ?? "8080";

app.Urls.Add($"http://+:{port}");

app.MapGet("/", (HttpRequest request) =>
{
  request.Query.TryGetValue("len", out StringValues len);
  request.Query.TryGetValue("prefix", out StringValues prefix);
  request.Query.TryGetValue("proto", out StringValues proto);
  string number = $"{RegistryNumberHelper.generatePrefix(proto, prefix)}{RegistryNumberHelper.generateNumber(len)}{RegistryNumberHelper.generateSuffix()}";
  Console.WriteLine($"{number}");
  return number;
});

app.Run();
