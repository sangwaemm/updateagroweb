document.addEventListener('DOMContentLoaded', function() {
  // Image Slider Logic
  const slides = document.querySelectorAll('.image-slider .slide');
  let currentSlide = 0;
  const slideInterval = 5000; // 5 seconds

  function nextSlide() {
    slides[currentSlide].classList.remove('active');
    currentSlide = (currentSlide + 1) % slides.length;
    slides[currentSlide].classList.add('active');
  }

  // Start the slider
  if (slides.length > 0) {
    slides[0].classList.add('active'); // Show the first slide initially
    setInterval(nextSlide, slideInterval);
  }
});
