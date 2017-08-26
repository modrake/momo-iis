using Microsoft.AspNet.Mvc;
using System;

namespace CharacterSheetApp.Controllers
{
  public class HomeController : Controller
  {
    public IActionResult Index()
    {
      var name = "Shield";
      return View("Index",name);
    }
  }
}