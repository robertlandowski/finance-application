var animatePoints = function() {

                       var header = document.getElementsByClassName('landing-header');

                       var revealFirstPoint = function() {
                           header[0].style.opacity = 1;
                           header[0].style.transform = "scaleX(1) translateY(0)";
                           header[0].style.msTransform = "scaleX(1) translateY(0)";
                           header[0].style.WebkitTransform = "scaleX(1) translateY(0)";
                       };

                       var revealSecondPoint = function() {
                           header[1].style.opacity = 1;
                           header[1].style.transform = "scaleX(1) translateY(0)";
                           header[1].style.msTransform = "scaleX(1) translateY(0)";
                           header[1].style.WebkitTransform = "scaleX(1) translateY(0)";
                       };

                       var revealThirdPoint = function() {
                           header[2].style.opacity = 1;
                           header[2].style.transform = "scaleX(1) translateY(0)";
                           header[2].style.msTransform = "scaleX(1) translateY(0)";
                           header[2].style.WebkitTransform = "scaleX(1) translateY(0)";
                       };

                       var revealFourthPoint = function() {
                           header[3].style.opacity = 1;
                           header[3].style.transform = "scaleX(1) translateY(0)";
                           header[3].style.msTransform = "scaleX(1) translateY(0)";
                           header[3].style.WebkitTransform = "scaleX(1) translateY(0)";
                       };

                       var revealFifthPoint = function() {
                           header[4].style.opacity = 1;
                           header[4].style.transform = "scaleX(1) translateY(0)";
                           header[4].style.msTransform = "scaleX(1) translateY(0)";
                           header[4].style.WebkitTransform = "scaleX(1) translateY(0)";
                       };

                       revealFirstPoint();
                       revealSecondPoint();
                       revealThirdPoint();
                       revealFourthPoint();
                       revealFifthPoint();
                       };
 animatePoints();
