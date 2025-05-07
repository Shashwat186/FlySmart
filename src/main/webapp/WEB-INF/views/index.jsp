<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FLYSMART | Flight Reservation System</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&family=Montserrat:wght@800&display=swap');
        
        :root {
            --color-light: #F5EEDC;
            --color-primary: #27548A;
            --color-dark: #183B4E;
            --color-accent: #DDA853;
            --glass-bg: rgba(39, 84, 138, 0.15);
            --glass-border: 1px solid rgba(221, 168, 83, 0.3);
            --glass-shadow: 0 8px 32px rgba(24, 59, 78, 0.3);
            --glass-blur: blur(12px);
            --glass-radius: 16px;
            --black: #121111;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }
        
        body {
            min-height: 100vh;
            overflow-x: hidden;
            color: var(--color-light);
        }
        
        #video-background {
            position: fixed;
            right: 0;
            bottom: 0;
            min-width: 100%;
            min-height: 100%;
            z-index: -1;
            object-fit: cover;
        }
        
        .overlay {
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 2rem;
        }
        
        .container {
            max-width: 1200px;
            width: 100%;
            padding: 2rem;
        }
        
        .main-content {
            -webkit-backdrop-filter: var(--glass-blur);
            background: var(--glass-bg);
            border: 3px solid var(--color-accent);
            border-radius: var(--glass-radius);
            box-shadow: var(--glass-shadow);
            padding: 3rem;
            text-align: center;
        }
        
        @keyframes borderGlow {
            0% { border-color: var(--color-accent); box-shadow: 0 0 15px var(--color-accent); }
            20% { border-color: #FF8C00; box-shadow: 0 0 15px #FF8C00; }
            40% { border-color: #FF4500; box-shadow: 0 0 15px #FF4500; }
            60% { border-color: #FF69B4; box-shadow: 0 0 15px #FF69B4; }
            80% { border-color: #9370DB; box-shadow: 0 0 15px #9370DB; }
            100% { border-color: var(--color-accent); box-shadow: 0 0 15px var(--color-accent); }
        }
        
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .header {
            margin-bottom: 3rem;
        }
        
        h1 {
            font-family: 'Montserrat', sans-serif;
            font-size: 4.5rem;
            color: var(--color-light);
            margin-bottom: 0.5rem;
            text-shadow: 4px 4px 4px rgba(26 25 23 / 50%), 
                        -1px -1px 0 var(--black),  
                        1px -1px 0 var(--black),
                        -1px 1px 0 var(--black),
                        1px 1px 0 var(--black);
            letter-spacing: 2px;
        }
        
        .subtitle {
            font-size: 2rem;
            margin-bottom: 2rem;
            text-shadow: 4px 4px 4px rgb(20 2 2 / 50%);
            color: var(--color-light);
            text-shadow: 4px 4px 4px rgba(26 25 23 / 50%), -1px -1px 0 var(--black), 1px -1px 0 var(--black), -1px 1px 0 var(--black), 1px 1px 0 var(--black);
        }
        
        .tagline {
            font-size: 1.5rem;
            margin-bottom: 3rem;
            opacity: 0.9;
            text-shadow: 4px 4px 4px rgb(20 2 2 / 50%);
            font-style: oblique;
            color: var(--color-light);
            font-weight: 600;
            text-shadow: 4px 4px 4px rgba(26 25 23 / 50%), -1px -1px 0 var(--black), 1px -1px 0 var(--black), -1px 1px 0 var(--black), 1px 1px 0 var(--black);
        }
        
        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 2rem;
            margin: 3rem 0;
        }
        
        .feature-card {
            backdrop-filter: var(--glass-blur);
            -webkit-backdrop-filter: var(--glass-blur);
            border: 3px solid var(--color-accent);
            border-radius: var(--glass-radius);
            padding: 2rem;
            transition: all 0.4s ease;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .feature-card:hover {
            background: var(--color-primary);
            box-shadow: 0 15px 30px rgba(24, 59, 78, 0.3);
            transform: translateY(-15px) !important; 
        }
        
        .feature-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: var(--color-light);
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
            backdrop-filter: var(--glass-blur);
            -webkit-backdrop-filter: var(--glass-blur);
            background: rgba(245, 238, 220, 0.3);
            border: 3px solid var(--color-accent);
            border-radius: 50%;
            width: 80px;
            height: 80px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
        }
        
        .feature-card:hover .feature-icon {
            transform: rotate(15deg) scale(1.1);
            background: var(--color-dark);
        }
        
        .feature-card h3 {
            margin-bottom: 1rem;
            font-size: 1.8rem;
            text-shadow: 4px 4px 4px rgb(31 28 28 / 50%);
            color: var(--color-light);
            text-shadow: 4px 4px 4px rgba(26 25 23 / 50%), -1px -1px 0 var(--black), 1px -1px 0 var(--black), -1px 1px 0 var(--black), 1px 1px 0 var(--black);
        }
        
        .feature-card p {
            opacity: 0.9;
            font-size: 1.2rem;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
            color: var(--color-accent);
            font-weight: 600;
            text-shadow: 4px 4px 4px rgb(42 40 41), 2px 2px 0 #121111, 1px -1px 0 #121111, -1px 1px 0 var(--black), 1px 1px 0 #121111;
        }
        
        .buttons {
            display: flex;
            justify-content: center;
            gap: 2rem;
            margin: 3rem 0;
            flex-wrap: wrap;
        }
        
        .btn {
            padding: 1rem 2.5rem;
            border-radius: 50px;
            font-size: 1.3rem;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.4s ease;
            position: relative;
            overflow: hidden;
            border: none;
            display: flex;
            align-items: center;
            gap: 10px;
            backdrop-filter: var(--glass-blur);
            -webkit-backdrop-filter: var(--glass-blur);
            background: rgba(221, 168, 83, 0.4);
            border: 3px solid var(--color-accent);
            color: var(--color-light);
            text-shadow: 4px 4px 4px rgba(26 25 23 / 50%), -1px -1px 0 var(--black), 1px -1px 0 var(--black), -1px 1px 0 var(--black), 1px 1px 0 var(--black);
        }
        
        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(
                90deg,
                transparent,
                rgba(255, 255, 255, 0.3),
                transparent
            );
            transition: 0.5s;
        }
        
        .btn:hover::before {
            left: 100%;
        }
        
        .btn:hover {
            transform: translateY(-5px);
            background: var(--color-primary);
        }
        
        .btn-login {
            background: rgba(221, 168, 83, 0.5);
        }
        
        .btn-register {
            background: var(--color-primary);
            color: var(--color-light);
        }
        
        .btn-register:hover {
            transform: translateY(-5px);
            background: rgba(221, 168, 83, 0.5);
        }
        
        .testimonials {
            margin: 3rem 0;
        }
        
        .testimonials h2 {
            font-size: 2.2rem;
            margin-bottom: 2rem;
            text-shadow: 4px 4px 4px rgb(20 2 2 / 50%);
            color: var(--color-light);
            text-shadow: 4px 4px 4px rgba(26 25 23 / 50%), -1px -1px 0 var(--black), 1px -1px 0 var(--black), -1px 1px 0 var(--black), 1px 1px 0 var(--black);
        }
        
        .testimonial-card {
            backdrop-filter: var(--glass-blur);
            -webkit-backdrop-filter: var(--glass-blur);
            background: rgba(24, 59, 78, 0.3);
            border: 3px solid var(--color-accent);
            border-radius: var(--glass-radius);
            padding: 2rem;
            margin: 1rem 0;
            transition: all 0.3s ease;
        }
        
        .testimonial-card:hover {
            transform: scale(1.02) !important;
            background: var(--color-primary);
        }
        
        .quote {
            font-style: italic;
            margin-bottom: 1rem;
            font-size: 1.3rem;
            text-shadow: 4px 4px 4px rgb(20 2 2 / 50%);
            color: var(--color-light);
            font-weight: 700;
            padding: 1rem;
            border-radius: 8px;
            transition: background-color 0.3s ease;
            text-shadow: 4px 4px 4px rgba(26 25 23 / 50%), -1px -1px 0 var(--black), 1px -1px 0 var(--black), -1px 1px 0 var(--black), 1px 1px 0 var(--black);
        }

        .quote:hover {
            cursor: pointer;
        }
        
        .author {
            font-weight: 600;
            text-align: right;
            font-size: 1.2rem;
            color: var(--color-accent);
            text-shadow: 4px 4px 4px rgb(20 2 2 / 50%);
            text-shadow: 4px 4px 4px rgba(26 25 23 / 50%), -1px -1px 0 var(--black), 1px -1px 0 var(--black), -1px 1px 0 var(--black), 1px 1px 0 var(--black);
        }
        
        .footer {
            margin-top: 3rem;
            text-align: center;
            padding: 2rem;
            backdrop-filter: var(--glass-blur);
            -webkit-backdrop-filter: var(--glass-blur);
            background: rgba(24, 59, 78, 0.3);
            border-radius: var(--glass-radius);
            border: 3px solid var(--color-accent);
            transition: all 0.4s ease-in-out;
        }

        .footer:hover {
            background: var(--color-primary);
            transform: translateY(-15px);
        }
        
        .social-icons {
            display: flex;
            justify-content: center;
            gap: 1.5rem;
            margin: 1.5rem 0;
        }
        
        .social-icon {
            font-size: 1.8rem;
            transition: all 0.3s ease;
            backdrop-filter: var(--glass-blur);
            -webkit-backdrop-filter: var(--glass-blur);
            background: rgba(245, 238, 220, 0.3);
            border: 3px solid var(--color-accent);
            border-radius: 50%;
            width: 60px;
            height: 60px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--color-light);
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
        }
        
        .social-icon:hover {
            transform: rotate(15deg) scale(1.1);
            background: var(--color-dark);
        }
        
        .copyright {
            font-size: 1.2rem;
            color: var(--color-accent);
            font-weight: 600;
            text-shadow: 4px 4px 4px rgba(26 25 23 / 50%), -1px -1px 0 var(--black), 1px -1px 0 var(--black), -1px 1px 0 var(--black), 1px 1px 0 var(--black);
        }
        
        @media (max-width: 768px) {
            h1 {
                font-size: 3rem;
            }
            
            .subtitle {
                font-size: 1.5rem;
            }
            
            .buttons {
                flex-direction: column;
                align-items: center;
            }
            
            .btn {
                width: 100%;
                justify-content: center;
            }
            
            .main-content {
                padding: 2rem 1rem;
            }
        }
    </style>
</head>
<body>
    <video autoplay muted loop id="video-background">
        <source src="https://videos.pexels.com/video-files/11737964/11737964-sd_640_360_30fps.mp4" type="video/mp4">
    </video>
    
    <div class="overlay">
        <div class="container">
            <div class="main-content">
                <div class="header">
                    <h1>FLYSMART</h1>
                    <div class="subtitle"><b>FLIGHT RESERVATION SYSTEM</b></div>
                    <p class="tagline"><b>"Your Journey Begins Here - Where Dreams Take Flight"</b></p>
                </div>
                
                <div class="features">
                    <div class="feature-card" data-scroll="right">
                        <div class="feature-icon">✈️</div>
                        <h3>Global Flight Network</h3>
                        <p style="text-shadow: 5px 5px 5px rgba(0, 0, 0, 0.5), -1px -1px 0 #1c1b19, 1px -1px 0 var(--black), -1px 1px 0 var(--black), 1px 1px 0 var(--black);">Access to 5,000+ destinations with 200+ airline partners worldwide</p>
                    </div>
                    <div class="feature-card" data-scroll="left">
                        <div class="feature-icon">💰</div>
                        <h3>Best Price Guarantee</h3>
                        <p style="text-shadow: 5px 5px 5px rgba(0, 0, 0, 0.5), -1px -1px 0 #1c1b19, 1px -1px 0 var(--black), -1px 1px 0 var(--black), 1px 1px 0 var(--black);">We'll match or beat any competitor's price for the same flight</p>
                    </div>
                    <div class="feature-card" data-scroll="right">
                        <div class="feature-icon">🛡️</div>
                        <h3>Stress-Free Travel</h3>
                        <p style="text-shadow: 5px 5px 5px rgba(0, 0, 0, 0.5), -1px -1px 0 #1c1b19, 1px -1px 0 var(--black), -1px 1px 0 var(--black), 1px 1px 0 var(--black);">24/7 customer support and free rebooking options</p>
                    </div>
                </div>
                
                <div class="testimonials">
                    <h2>Why Travelers Love FLYSMART</h2>
                    <div class="testimonial-card" data-scroll="left">
                        <p class="quote">"FLYSMART: Revolutionizing air travel  with cutting-edge technology and personalized service. Connecting you to various destinations with one mission: making your booking as effortless as your journey."</p>
                        <p class="author">- About Us</p>
                    </div>
                    <div class="testimonial-card" data-scroll="right">
                        <p class="quote">"We make luxury travel accessible for all. Choose from budget-friendly Economy  to premium fares, with  price match, and seasonal deals—because exceptional travel shouldn’t break the bank."</p>
                        <p class="author">-Affordable For Everyone </p>
                    </div>
                    <div class="testimonial-card" data-scroll="left">
                        <p class="quote">"FLYSMART is an comprehensive and customer-friendly application."</p>
                        <p class="author">- FLYSMART Amenities</p>
                    </div>
                    <div class="testimonial-card" data-scroll="right">
                        <p class="quote">"All in one comprehensive applications serving with brilliant sevices across the client and service side."</p>
                        <p class="author">Executive Traveler</p>
                    </div>
                </div>
                
                <div class="buttons">
                    <a href="${pageContext.request.contextPath}/auth/login" class="btn btn-login">🔑 Login</a>
                    <a href="${pageContext.request.contextPath}/auth/register" class="btn btn-register">✍️ Register</a>
                </div>
                
                <div class="footer">
                    <p class="tagline">"The Sky Awaits - Where Will FLYSMART Take You Today?"</p>
                    <div class="social-icons">
                        <a href="#" class="social-icon">📱</a>
                        <a href="#" class="social-icon">💬</a>
                        <a href="#" class="social-icon">📧</a>
                        <a href="#" class="social-icon">📞</a>
                    </div>
                    <p class="copyright">© 2025 FLYSMART | The Most Trusted Name in Air Travel</p>
                    <p class="copyright">Contact: support@flysmart.com | 24/7 Helpline: +1-800-FLY-SMART (359-7627)</p>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        // Video background setup with fallback
        document.addEventListener('DOMContentLoaded', function() {
            const video = document.getElementById('video-background');
            video.playbackRate = 0.8;
            
            // Fallback for mobile autoplay
            if (window.innerWidth < 768) {
                video.play().catch(e => {
                    video.poster = 'https://images.unsplash.com/photo-1436491865332-7a61a109cc05?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80';
                });
            }
            
            // Scroll animations
            const animateOnScroll = function() {
                const elements = document.querySelectorAll('[data-scroll]');
                
                elements.forEach(element => {
                    const elementPosition = element.getBoundingClientRect().top;
                    const screenPosition = window.innerHeight / 1.3;
                    
                    if (elementPosition < screenPosition) {
                        const direction = element.getAttribute('data-scroll');
                        element.style.opacity = '1';
                        element.style.transform = direction === 'left' ? 'translateX(0)' : 'translateX(0)';
                    }
                });
            };
            
            // Set initial state
            const scrollElements = document.querySelectorAll('[data-scroll]');
            scrollElements.forEach(el => {
                const direction = el.getAttribute('data-scroll');
                el.style.opacity = '0';
                el.style.transform = direction === 'left' ? 'translateX(-100px)' : 'translateX(100px)';
                el.style.transition = 'all 0.8s ease';
            });
            
            window.addEventListener('scroll', animateOnScroll);
            animateOnScroll(); // Trigger once on load
        });
    </script>
</body>
</html>