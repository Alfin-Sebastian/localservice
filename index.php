<?php
session_start();
include 'db.php';
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>UrbanServe | Book Trusted Local Services</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
  <style>
    /* CSS styles preserved (use original CSS from inde.txt or existing index.php) */
  </style>
</head>
<body>

<!-- Header -->
<header class="header">
  <div class="container">
    <nav class="navbar">
      <a href="index.php" class="logo">Urban<span>Serve</span></a>
      <div class="nav-links">
        <a href="services.php">Services</a>
        <a href="providers.html">Providers</a>
        <a href="about.html">About Us</a>
        <a href="contact.html">Contact</a>
      </div>
      <div class="auth-buttons">
        <?php if (isset($_SESSION['user'])): ?>
          <span>Hi, <?= htmlspecialchars($_SESSION['user']['name']) ?></span>
          <a href="logout.php" class="btn btn-outline">Logout</a>
        <?php else: ?>
          <a href="login.php" class="btn btn-outline">Log In</a>
          <a href="register.php" class="btn btn-primary">Sign Up</a>
        <?php endif; ?>
      </div>
    </nav>
  </div>
</header>

<!-- Hero Section -->
<section class="hero">
  <div class="container">
    <h1>Book Trusted Home Services Near You</h1>
    <p>Discover and book the best professionals for all your home service needs. Quality guaranteed.</p>
    <div class="search-box">
      <form method="GET" action="services.php" style="display: flex; width: 100%;">
        <input type="text" name="search" placeholder="What service are you looking for?" />
        <button><i class="fas fa-search"></i> Search</button>
      </form>
    </div>
  </div>
</section>
<!-- Popular Services -->
<section class="categories">
  <div class="container">
    <h2 class="section-title">Popular Services</h2>
    <p class="section-subtitle">Browse our most requested services from trusted professionals in your area</p>

    <div class="category-grid">
      <?php
      $services = $conn->query("SELECT * FROM services LIMIT 8");
      if ($services->num_rows > 0):
        while ($service = $services->fetch_assoc()):
      ?>
      <div class="category-card">
        <div class="category-icon">
          <i class="fas fa-cogs"></i> <!-- You can customize icons by category name -->
        </div>
        <h3><?= htmlspecialchars($service['name']) ?></h3>
      </div>
      <?php endwhile; else: ?>
      <p>No services available yet.</p>
      <?php endif; ?>
    </div>
  </div>
</section>
<!-- Featured Providers -->
<section class="featured-providers">
  <div class="container">
    <h2 class="section-title">Featured Service Providers</h2>
    <p class="section-subtitle">Top-rated professionals trusted by thousands of customers</p>

    <div class="providers-grid">
      <?php
      $query = "
        SELECT p.id AS provider_id, u.name, u.id AS user_id, s.name AS service_name, s.id AS service_id
        FROM providers p
        JOIN users u ON p.user_id = u.id
        JOIN services s ON p.service_id = s.id
        LIMIT 6
      ";
      $providers = $conn->query($query);
      if ($providers->num_rows > 0):
        while ($row = $providers->fetch_assoc()):
      ?>
      <div class="provider-card">
        <div class="provider-image" style="background-image: url('https://source.unsplash.com/random/500x300?person');"></div>
        <div class="provider-info">
          <h3><?= htmlspecialchars($row['name']) ?></h3>
          <div class="provider-services">
            <i class="fas fa-check-circle"></i> <?= htmlspecialchars($row['service_name']) ?>
          </div>
          <div class="provider-price">From ₹500</div>
          <div class="provider-actions">
            <a href="#" class="btn btn-outline">View Profile</a>
            <?php if (isset($_SESSION['user']) && $_SESSION['user']['role'] === 'customer'): ?>
              <a href="book_service.php?provider_id=<?= $row['user_id'] ?>&service_id=<?= $row['service_id'] ?>" class="btn btn-primary">Book Now</a>
            <?php else: ?>
              <a href="login.php" class="btn btn-primary">Login to Book</a>
            <?php endif; ?>
          </div>
        </div>
      </div>
      <?php endwhile; else: ?>
        <p>No providers found.</p>
      <?php endif; ?>
    </div>
  </div>
</section>
<!-- Testimonials -->
<section class="testimonials">
  <div class="container">
    <h2 class="section-title">What Our Customers Say</h2>
    <p class="section-subtitle">Hear from people who have used our services</p>

    <div class="testimonial-slider">
      <div class="testimonial">
        <p class="testimonial-text">"UrbanServe made it so easy to find trusted help. I booked cleaning and plumbing back-to-back!"</p>
        <div class="testimonial-author">
          <img src="https://randomuser.me/api/portraits/women/43.jpg" alt="Jessica T.">
          <div>
            <div>Jessica T.</div>
            <small>Homeowner</small>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Call to Action -->
<section class="cta">
  <div class="container">
    <h2>Ready to get started?</h2>
    <p>Join thousands of satisfied customers who trust UrbanServe for their home service needs.</p>
    <a href="register.php" class="btn btn-accent">Sign Up Now</a>
  </div>
</section>

<!-- Footer -->
<footer class="footer">
  <div class="container">
    <div class="footer-grid">
      <div class="footer-column">
        <h3>Company</h3>
        <ul>
          <li><a href="about.html">About Us</a></li>
          <li><a href="careers.html">Careers</a></li>
          <li><a href="blog.html">Blog</a></li>
          <li><a href="press.html">Press</a></li>
        </ul>
      </div>
      <div class="footer-column">
        <h3>Services</h3>
        <ul>
          <li><a href="services.php?category=cleaning">Cleaning</a></li>
          <li><a href="services.php?category=repairs">Repairs</a></li>
          <li><a href="services.php?category=plumbing">Plumbing</a></li>
          <li><a href="services.php?category=electrical">Electrical</a></li>
        </ul>
      </div>
      <div class="footer-column">
        <h3>Support</h3>
        <ul>
          <li><a href="contact.html">Contact Us</a></li>
          <li><a href="faq.html">FAQs</a></li>
          <li><a href="privacy.html">Privacy Policy</a></li>
          <li><a href="terms.html">Terms of Service</a></li>
        </ul>
      </div>
      <div class="footer-column">
        <h3>Connect With Us</h3>
        <div class="social-links">
          <a href="#"><i class="fab fa-facebook-f"></i></a>
          <a href="#"><i class="fab fa-twitter"></i></a>
          <a href="#"><i class="fab fa-instagram"></i></a>
          <a href="#"><i class="fab fa-linkedin-in"></i></a>
        </div>
        <div style="margin-top: 20px;">
          <p>Download our app:</p>
          <div style="display: flex; gap: 10px; margin-top: 10px;">
            <a href="#" style="background: #000; padding: 8px 12px; border-radius: 5px; display: flex; align-items: center;">
              <i class="fab fa-apple" style="margin-right: 8px;"></i><span>App Store</span>
            </a>
            <a href="#" style="background: #000; padding: 8px 12px; border-radius: 5px; display: flex; align-items: center;">
              <i class="fab fa-google-play" style="margin-right: 8px;"></i><span>Play Store</span>
            </a>
          </div>
        </div>
      </div>
    </div>
    <div class="copyright">
      &copy; <?= date('Y') ?> UrbanServe. All rights reserved.
    </div>
  </div>
</footer>

<!-- Scripts -->
<script>
  document.addEventListener('DOMContentLoaded', function () {
    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.style.opacity = 1;
          entry.target.style.transform = 'translateY(0)';
        }
      });
    }, { threshold: 0.1 });

    document.querySelectorAll('.category-card').forEach((card, index) => {
      card.style.opacity = 0;
      card.style.transform = 'translateY(20px)';
      card.style.transition = `all 0.3s ease ${index * 0.1}s`;
      observer.observe(card);
    });

    console.log('UrbanServe frontend loaded');
  });
</script>
</body>
</html>
