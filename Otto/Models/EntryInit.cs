using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Otto.Models
{

    public class EntryDataInit
    {
        private static List<Entry> GetEntries()
        {
            var products = new List<Entry> {
                new Entry
                {
                    Name = "Convertible Car",
                    Description = "TestTest",
                    Details = "This convertible car is fast! The engine is powered by a neutrino based battery (not included)." + 
                                  "Power it up and let it go!"
               },
                new Entry 
                {
                    Name = "Old-time Car",
                    Description = "Test2Test",
                    Details = "There's nothing old about this toy car, except it's looks. Compatible with other old toy cars."
               }
            };

            return products;
        }
    }
}