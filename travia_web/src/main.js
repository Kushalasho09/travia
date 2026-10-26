/* ==========================================================================
   Travia Connect - First 5,000 Subscribers Client Script
   ========================================================================== */

// Lightweight Canvas Confetti implementation (Zero dependency guarantee)
function fireConfetti() {
  const canvas = document.getElementById('confettiCanvas');
  if (!canvas) return;
  const ctx = canvas.getContext('2d');
  
  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;
  
  const pieces = [];
  const numberOfPieces = 120;
  const colors = ['#F25722', '#FFA57E', '#0D233A', '#2563EB', '#10B981', '#F59E0B', '#9333EA'];
  
  for (let i = 0; i < numberOfPieces; i++) {
    pieces.push({
      x: canvas.width / 2 + (Math.random() - 0.5) * 200,
      y: canvas.height * 0.4 + (Math.random() - 0.5) * 100,
      w: Math.random() * 10 + 6,
      h: Math.random() * 8 + 4,
      color: colors[Math.floor(Math.random() * colors.length)],
      vx: (Math.random() - 0.5) * 14,
      vy: Math.random() * -12 - 6,
      gravity: 0.35,
      rotation: Math.random() * 360,
      vRotation: (Math.random() - 0.5) * 12,
      opacity: 1,
    });
  }
  
  let animationFrameId;
  function update() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    let activePieces = 0;
    
    for (let p of pieces) {
      p.x += p.vx;
      p.y += p.vy;
      p.vy += p.gravity;
      p.rotation += p.vRotation;
      p.opacity -= 0.008;
      
      if (p.opacity > 0 && p.y < canvas.height + 50) {
        activePieces++;
        ctx.save();
        ctx.globalAlpha = Math.max(p.opacity, 0);
        ctx.translate(p.x, p.y);
        ctx.rotate((p.rotation * Math.PI) / 180);
        ctx.fillStyle = p.color;
        ctx.fillRect(-p.w / 2, -p.h / 2, p.w, p.h);
        ctx.restore();
      }
    }
    
    if (activePieces > 0) {
      animationFrameId = requestAnimationFrame(update);
    } else {
      ctx.clearRect(0, 0, canvas.width, canvas.height);
      cancelAnimationFrame(animationFrameId);
    }
  }
  
  update();
}

// Window resize listener for confetti
window.addEventListener('resize', () => {
  const canvas = document.getElementById('confettiCanvas');
  if (canvas) {
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
  }
});

// DOM Ready initialization
document.addEventListener('DOMContentLoaded', () => {
  // 1. Counter Animation
  const counterEl = document.getElementById('counterNumber');
  const targetCount = 2847;
  let hasAnimated = false;
  
  function animateCounter() {
    if (hasAnimated || !counterEl) return;
    hasAnimated = true;
    
    const duration = 2000;
    const startTime = performance.now();
    
    function step(currentTime) {
      const elapsed = currentTime - startTime;
      const progress = Math.min(elapsed / duration, 1);
      // Ease out cubic
      const ease = 1 - Math.pow(1 - progress, 3);
      const current = Math.floor(ease * targetCount);
      
      counterEl.textContent = current.toLocaleString('en-US');
      
      if (progress < 1) {
        requestAnimationFrame(step);
      } else {
        counterEl.textContent = targetCount.toLocaleString('en-US');
      }
    }
    
    requestAnimationFrame(step);
  }

  // Trigger counter when in view
  if ('IntersectionObserver' in window && counterEl) {
    const observer = new IntersectionObserver((entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          animateCounter();
        }
      });
    }, { threshold: 0.3 });
    observer.observe(counterEl);
  } else {
    animateCounter();
  }

  // 2. Video Modal Logic
  const videoModal = document.getElementById('videoModal');
  const videoTrigger = document.getElementById('videoTriggerCard');
  const closeVideoBtn = document.getElementById('closeVideoModalBtn');
  const simPlayBtn = document.getElementById('simPlayBtn');
  const simProgressBar = document.getElementById('simProgress');
  const simTime = document.getElementById('simTime');
  const simSteps = document.querySelectorAll('.feature-step');
  
  let isSimPlaying = false;
  let simInterval;
  let simSeconds = 0;
  const simDuration = 88; // 1:28 = 88 seconds

  function openVideoModal() {
    if (videoModal) {
      videoModal.classList.add('is-open');
      videoModal.setAttribute('aria-hidden', 'false');
      document.body.style.overflow = 'hidden';
      startSimPlayback();
    }
  }

  function closeVideoModal() {
    if (videoModal) {
      videoModal.classList.remove('is-open');
      videoModal.setAttribute('aria-hidden', 'true');
      document.body.style.overflow = '';
      stopSimPlayback();
    }
  }

  function startSimPlayback() {
    isSimPlaying = true;
    if (simPlayBtn) simPlayBtn.textContent = '⏸ Pause Demo';
    clearInterval(simInterval);
    
    simInterval = setInterval(() => {
      simSeconds += 2;
      if (simSeconds > simDuration) simSeconds = 0;
      
      const pct = (simSeconds / simDuration) * 100;
      if (simProgressBar) simProgressBar.style.width = `${pct}%`;
      
      const mins = Math.floor(simSeconds / 60);
      const secs = (simSeconds % 60).toString().padStart(2, '0');
      if (simTime) simTime.textContent = `${mins}:${secs} / 1:28`;
      
      // Step highlighting
      const stepIndex = Math.min(Math.floor((simSeconds / simDuration) * simSteps.length), simSteps.length - 1);
      simSteps.forEach((s, idx) => {
        s.classList.toggle('active', idx === stepIndex);
      });
    }, 400);
  }

  function stopSimPlayback() {
    isSimPlaying = false;
    if (simPlayBtn) simPlayBtn.textContent = '▶ Play Demo';
    clearInterval(simInterval);
  }

  if (videoTrigger) {
    videoTrigger.addEventListener('click', openVideoModal);
    videoTrigger.addEventListener('keydown', (e) => {
      if (e.key === 'Enter' || e.key === ' ') {
        e.preventDefault();
        openVideoModal();
      }
    });
  }

  if (closeVideoBtn) {
    closeVideoBtn.addEventListener('click', closeVideoModal);
  }

  if (simPlayBtn) {
    simPlayBtn.addEventListener('click', () => {
      if (isSimPlaying) {
        stopSimPlayback();
      } else {
        startSimPlayback();
      }
    });
  }

  // 3. Claim Spot Modal Logic
  const claimModal = document.getElementById('claimModal');
  const openClaimBtn = document.getElementById('openClaimModalBtn');
  const closeClaimBtn = document.getElementById('closeClaimModalBtn');
  const claimForm = document.getElementById('claimSpotForm');
  const claimSuccess = document.getElementById('claimSuccessState');
  const badgeName = document.getElementById('badgeGeneratedName');

  function openClaim() {
    if (claimModal) {
      claimModal.classList.add('is-open');
      claimModal.setAttribute('aria-hidden', 'false');
      document.body.style.overflow = 'hidden';
    }
  }

  function closeClaim() {
    if (claimModal) {
      claimModal.classList.remove('is-open');
      claimModal.setAttribute('aria-hidden', 'true');
      document.body.style.overflow = '';
    }
  }

  if (openClaimBtn) openClaimBtn.addEventListener('click', openClaim);
  if (closeClaimBtn) closeClaimBtn.addEventListener('click', closeClaim);

  // Close modals on backdrop click or ESC key
  [videoModal, claimModal].forEach((modal) => {
    if (!modal) return;
    modal.addEventListener('click', (e) => {
      if (e.target === modal) {
        closeVideoModal();
        closeClaim();
      }
    });
  });

  window.addEventListener('keydown', (e) => {
    if (e.key === 'Escape') {
      closeVideoModal();
      closeClaim();
    }
  });

  // Handle Form Submission
  if (claimForm) {
    claimForm.addEventListener('submit', async (e) => {
      e.preventDefault();
      const nameInput = document.getElementById('memberName');
      const phoneInput = document.getElementById('memberPhone');
      const name = nameInput ? nameInput.value.trim() : 'Valued Traveler';
      const phone = phoneInput ? phoneInput.value.trim() : '';
      
      let memberIdText = '#002848';
      try {
        const response = await fetch('/api/claim-spot', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ name, phone })
        });
        if (response.ok) {
          const data = await response.json();
          if (data.memberId) memberIdText = data.memberId;
        }
      } catch (err) {
        console.log('Using offline member assignment:', err);
      }

      const badgeId = document.getElementById('badgeGeneratedId');
      if (badgeId) badgeId.textContent = memberIdText;
      if (badgeName) badgeName.textContent = name;
      
      // Animate form away and show badge
      claimForm.style.display = 'none';
      if (claimSuccess) claimSuccess.style.display = 'block';
      
      // Update global counter
      if (counterEl) {
        counterEl.textContent = '2,848';
      }
      const liveText = document.querySelector('.live-text');
      if (liveText) liveText.textContent = '2,848 Joined';
      
      // Fire celebratory confetti!
      fireConfetti();
    });
  }

  // 4. Member card interactions
  const memberCards = document.querySelectorAll('.member-card');
  memberCards.forEach((card) => {
    card.addEventListener('click', () => {
      const name = card.getAttribute('data-name');
      const id = card.getAttribute('data-member');
      fireConfetti();
      showToast(`⭐ #${id} ${name} is a Verified Founding Member!`);
    });
  });

  // Simple Toast notification helper
  function showToast(message) {
    const existing = document.querySelector('.travia-toast');
    if (existing) existing.remove();
    
    const toast = document.createElement('div');
    toast.className = 'travia-toast';
    toast.textContent = message;
    
    Object.assign(toast.style, {
      position: 'fixed',
      bottom: '24px',
      left: '50%',
      transform: 'translateX(-50%) translateY(100px)',
      backgroundColor: '#0D233A',
      color: '#FFFFFF',
      padding: '12px 24px',
      borderRadius: '999px',
      boxShadow: '0 10px 30px rgba(0,0,0,0.25)',
      fontSize: '0.9rem',
      fontWeight: '600',
      zIndex: '10001',
      transition: 'transform 0.3s cubic-bezier(0.16, 1, 0.3, 1)',
      border: '1px solid #F25722'
    });
    
    document.body.appendChild(toast);
    
    requestAnimationFrame(() => {
      toast.style.transform = 'translateX(-50%) translateY(0)';
    });
    
    setTimeout(() => {
      toast.style.transform = 'translateX(-50%) translateY(100px)';
      setTimeout(() => toast.remove(), 350);
    }, 2800);
  }

  // 5. Terms Link
  const termsLink = document.getElementById('openTermsLink');
  if (termsLink) {
    termsLink.addEventListener('click', (e) => {
      e.preventDefault();
      showToast('📜 Founding Member perks are active for lifetime upon joining!');
    });
  }
});
