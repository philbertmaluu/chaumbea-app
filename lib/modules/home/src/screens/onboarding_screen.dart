import 'package:flutter/material.dart';
import 'package:chaumbea/modules/home/src/screens/home.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late AnimationController _floatingController;
  late Animation<double> _floatingAnimation;
  bool _isEnglish = true;

  @override
  void initState() {
    super.initState();
    _floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _floatingAnimation = Tween<double>(begin: -10.0, end: 10.0).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _floatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:
                isDark
                    ? [const Color(0xFF1A1A2E), const Color(0xFF16213E)]
                    : [const Color(0xFFF8F9FA), const Color(0xFFE9ECEF)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Language toggle
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => setState(() => _isEnglish = !_isEnglish),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.white10 : Colors.black12,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _isEnglish ? 'SW' : 'EN',
                        style: TextStyle(
                          color: isDark ? Colors.white70 : Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  flex: 6,
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors:
                            isDark
                                ? [
                                  const Color(0xFF2D1B69),
                                  const Color(0xFF11998E),
                                ]
                                : [
                                  const Color(0xFFFFE5F1),
                                  const Color(0xFFFFE5E5),
                                ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color:
                              isDark
                                  ? Colors.purple.withOpacity(0.3)
                                  : Colors.pink.withOpacity(0.2),
                          blurRadius: 25,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Stack(
                        children: [
                          // Background pattern
                          Positioned.fill(
                            child: CustomPaint(
                              painter: GossipPatternPainter(isDark: isDark),
                            ),
                          ),

                          // Floating gossip elements
                          AnimatedBuilder(
                            animation: _floatingAnimation,
                            builder: (context, child) {
                              return Stack(
                                children: [
                                  // Celebrity silhouettes
                                  Positioned(
                                    top: 60 + _floatingAnimation.value,
                                    left: 30,
                                    child: _buildCelebrityCard(
                                      Icons.person,
                                      Colors.pink[300]!,
                                      'Celebrity News',
                                    ),
                                  ),
                                  Positioned(
                                    top: 120 + (_floatingAnimation.value * -1),
                                    right: 40,
                                    child: _buildCelebrityCard(
                                      Icons.person_outline,
                                      Colors.purple[300]!,
                                      'Exclusive',
                                    ),
                                  ),

                                  // Gossip bubbles
                                  Positioned(
                                    top: 200 + _floatingAnimation.value,
                                    left: 50,
                                    child: _buildGossipBubble(
                                      '💬',
                                      Colors.orange[300]!,
                                      isDark,
                                    ),
                                  ),
                                  Positioned(
                                    top: 160 + (_floatingAnimation.value * -1),
                                    right: 60,
                                    child: _buildGossipBubble(
                                      '🔥',
                                      Colors.red[300]!,
                                      isDark,
                                    ),
                                  ),

                                  // Premium badges
                                  Positioned(
                                    bottom: 120 + _floatingAnimation.value,
                                    left: 40,
                                    child: _buildPremiumBadge(
                                      Icons.diamond,
                                      Colors.yellow[600]!,
                                      'VIP',
                                    ),
                                  ),
                                  Positioned(
                                    bottom:
                                        180 + (_floatingAnimation.value * -1),
                                    right: 30,
                                    child: _buildPremiumBadge(
                                      Icons.star,
                                      Colors.amber[500]!,
                                      'HOT',
                                    ),
                                  ),

                                  // Center content
                                  Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.campaign,
                                          size: 80,
                                          color:
                                              isDark
                                                  ? Colors.white70
                                                  : Colors.pink[400],
                                        ),
                                        const SizedBox(height: 20),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                isDark
                                                    ? Colors.white10
                                                    : Colors.white70,
                                            borderRadius: BorderRadius.circular(
                                              25,
                                            ),
                                          ),
                                          child: Text(
                                            _isEnglish
                                                ? 'PREMIUM GOSSIP'
                                                : 'UVUMI WA KIFAHARI',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  isDark
                                                      ? Colors.white
                                                      : Colors.pink[700],
                                              letterSpacing: 2,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Content section
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _isEnglish
                            ? 'GET EXCLUSIVE GOSSIP\n& ENTERTAINMENT'
                            : 'PATA UVUMI WA KIPEKEE\n& BURUDANI',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: isDark ? Colors.white : Colors.black87,
                          height: 1.2,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 20),

                      Text(
                        _isEnglish
                            ? 'Subscribe to premium content with exclusive\nphotos, videos, and celebrity stories.'
                            : 'Jiunga na maudhui ya kifahari yenye picha,\nvideo na hadithi za nje za waigizaji.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: isDark ? Colors.white70 : Colors.grey[600],
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Premium features
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildFeatureItem(
                            Icons.photo_library,
                            _isEnglish ? 'Photos' : 'Picha',
                            isDark,
                          ),
                          _buildFeatureItem(
                            Icons.video_library,
                            _isEnglish ? 'Videos' : 'Video',
                            isDark,
                          ),
                          _buildFeatureItem(
                            Icons.article,
                            _isEnglish ? 'Stories' : 'Hadithi',
                            isDark,
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),

                      // Subscribe button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE91E63),
                            foregroundColor: Colors.white,
                            elevation: 8,
                            shadowColor: Colors.pink.withOpacity(0.4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.diamond,
                                size: 20,
                                color: Colors.yellow[300],
                              ),
                              const SizedBox(width: 12),
                              Text(
                                _isEnglish
                                    ? 'Start Exploring'
                                    : 'Anza Kuchunguza',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.arrow_forward, size: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCelebrityCard(IconData icon, Color color, String label) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [color, color.withOpacity(0.7)]),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 30),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 8,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGossipBubble(String emoji, Color color, bool isDark) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: isDark ? color.withOpacity(0.8) : color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(child: Text(emoji, style: const TextStyle(fontSize: 24))),
    );
  }

  Widget _buildPremiumBadge(IconData icon, Color color, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String label, bool isDark) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFE91E63), Color(0xFF9C27B0)],
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.pink.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: isDark ? Colors.white70 : Colors.grey[700],
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class GossipPatternPainter extends CustomPainter {
  final bool isDark;

  GossipPatternPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color =
              isDark
                  ? Colors.white.withOpacity(0.05)
                  : Colors.pink.withOpacity(0.1)
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;

    // Draw gossip-themed patterns
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 3; j++) {
        final center = Offset(
          (size.width / 5) * i + (size.width / 10),
          (size.height / 3) * j + (size.height / 6),
        );

        // Draw chat bubble shapes
        canvas.drawCircle(center, 15, paint);
        canvas.drawCircle(center.translate(20, 10), 8, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
