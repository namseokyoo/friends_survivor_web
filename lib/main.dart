import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
// import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/scheduler.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Friends Survivor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Uint8List? selectedImageBytes;
  List<Uint8List> enemyImageBytes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Friends Survivor',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cursive',
                ),
              ),
              const Text(
                'v0.2',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cursive',
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();
                          final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery);
                          if (image != null) {
                            final Uint8List imageBytes =
                                await image.readAsBytes();
                            setState(() {
                              selectedImageBytes = imageBytes;
                            });
                          }
                        },
                        child: const Text('주인공 사진 적용'),
                      ),
                      const SizedBox(height: 20),
                      selectedImageBytes != null
                          ? ClipOval(
                              child: Image.memory(
                                selectedImageBytes!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                            ),
                    ],
                  ),
                  const SizedBox(width: 50),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();
                          final List<XFile> images =
                              await picker.pickMultiImage();
                          if (images.isNotEmpty) {
                            List<Uint8List> newEnemyImages = [];
                            for (var image in images) {
                              newEnemyImages.add(await image.readAsBytes());
                            }
                            setState(() {
                              enemyImageBytes = newEnemyImages;
                            });
                          }
                        },
                        child: const Text('적 사진 적용'),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          for (var i = 0; i < 7; i++)
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: [
                                      Colors.red,
                                      Colors.orange,
                                      Colors.yellow,
                                      Colors.green,
                                      Colors.blue,
                                      Colors.indigo,
                                      Colors.purple
                                    ][i],
                                    width: 2,
                                  ),
                                ),
                                child: i < enemyImageBytes.length
                                    ? ClipOval(
                                        child: Image.memory(
                                          enemyImageBytes[i],
                                          width: 30,
                                          height: 30,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: [
                                            Colors.red,
                                            Colors.orange,
                                            Colors.yellow,
                                            Colors.green,
                                            Colors.blue,
                                            Colors.indigo,
                                            Colors.purple
                                          ][i],
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GameScreen(
                        imageBytes: selectedImageBytes,
                        enemyImageBytes: enemyImageBytes,
                      ),
                    ),
                  );
                },
                child: const Text('게임 시작'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Enemy class
class Enemy {
  double x, y;
  int level;
  late final int attackPower;
  late final Color color;
  final double speed = 1.2; // 적 이동 속도
  bool isActive = true;
  late int health;

  Enemy(this.x, this.y, this.level) {
    attackPower = 10;
    health = 4 + (level - 1) * 4;
    color = _getColorForLevel(level);
  }

  Color _getColorForLevel(int level) {
    final random = math.Random();
    switch (level) {
      case 1:
        return Colors.red;
      case 2:
        return random.nextBool() ? Colors.red : Colors.orange;
      case 3:
        return random.nextBool() ? Colors.orange : Colors.yellow;
      case 4:
        return random.nextBool() ? Colors.yellow : Colors.green;
      case 5:
        return random.nextBool() ? Colors.green : Colors.blue;
      case 6:
        return random.nextBool() ? Colors.blue : Colors.indigo;
      case 7:
        return random.nextBool() ? Colors.indigo : Colors.purple;
      default:
        return Colors.grey;
    }
  }

  void moveTowardsPlayer(double playerX, double playerY) {
    final dx = playerX - x;
    final dy = playerY - y;
    final distance = math.sqrt(dx * dx + dy * dy);
    if (distance > 0) {
      x += (dx / distance) * speed;
      y += (dy / distance) * speed;
    }
  }

  bool checkCollision(double playerX, double playerY) {
    final dx = playerX - x;
    final dy = playerY - y;
    final distance = math.sqrt(dx * dx + dy * dy);
    return distance < 40;
  }
}

// Projectile class
class Projectile {
  double x;
  double y;
  double speed;
  double angle;
  bool isActive;
  double power;

  Projectile({
    required this.x,
    required this.y,
    required this.speed,
    required this.angle,
    this.isActive = true,
    required this.power,
  });

  void move() {
    x += math.cos(angle) * speed;
    y += math.sin(angle) * speed;
  }

  bool checkCollision(Enemy enemy) {
    final dx = enemy.x + 15 - (x + 5);
    final dy = enemy.y + 15 - (y + 5);
    final distance = math.sqrt(dx * dx + dy * dy);
    final combinedRadius = 15 + 5;
    return distance < combinedRadius;
  }
}

// Experience Point 클래스 추가
class ExperiencePoint {
  final Offset position;
  final bool isTriple;
  final int value;

  Color get color => isTriple ? Colors.green : Colors.yellow;

  ExperiencePoint(this.position, this.isTriple) : value = isTriple ? 3 : 1;
}

class GameScreen extends StatefulWidget {
  final Uint8List? imageBytes;
  final List<Uint8List> enemyImageBytes;

  const GameScreen({
    super.key,
    this.imageBytes,
    this.enemyImageBytes = const [],
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  bool _isUsingJoystick = false;
  // Player position and movement
  double playerX = 100.0;
  double playerY = 100.0;
  double velocityX = 0.0;
  double velocityY = 0.0;
  final double moveSpeed = 2.5; // 플레이어 이동 속도
  final double maxSpeed = 6.4; // 최대 이동 속도
  final double friction = 0.85; // 마찰 계수
  double playerHealth = 100.0; // 플레이어 체력

  // Enemy management
  final List<Enemy> enemies = [];
  final math.Random random = math.Random();
  double spawnTimer = 0;
  double spawnInterval = 1.5; // 적이 발생하는 기본 간격 (초 단위)

  // Projectile management
  final List<Projectile> projectiles = [];

  // Key state tracking
  final Set<LogicalKeyboardKey> _pressedKeys = {};

  // Animation controller for game loop
  late Ticker _ticker;

  // Experience management
  final List<ExperiencePoint> experiencePoints = [];
  int playerLevel = 1;
  int experienceCollected = 0; // 경험치 수집량
  int experienceNeeded = 10; // 경험치 필요량

  // Timer for automatic firing
  double fireTimer = 0; // 발사 타이머
  double fireInterval = 0.7; // 발사 간격

  // Weapon upgrade options
  int projectileCount = 1; // 발사체 개수
  double projectilePower = 1.0; // 발사체 데미지

  double maxPlayerHealth = 100.0; // 최대 체력
  int upgradeCount = 0; // 업그레이드 횟수
  double gameTime = 0.0; // 게임 시간

  // Upgrade counts
  int fireRateUpgradeCount = 0; // 발사 속도 업그레이드 횟수
  int projectileCountUpgradeCount = 0; // 발사체 개수 업그레이드 횟수
  int projectilePowerUpgradeCount = 0; // 발사체 데미지 업그레이드 횟수

  final FocusNode _focusNode = FocusNode();

  // 게임 상태 관리를 한 변수 추가
  bool _isGamePaused = false;

  // 게임 초기화 및 설정
  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    _ticker = createTicker(_gameLoop);
    playerHealth = 100.0;
    maxPlayerHealth = 100.0;
    playerLevel = 1;
    experienceCollected = 0;
    experienceNeeded = 10;
    projectileCount = 1;
    projectilePower = 1.0;
    fireInterval = 0.5;
    spawnInterval = 1.5;
    gameTime = 0.0;
    upgradeCount = 0;
    fireRateUpgradeCount = 0;
    projectileCountUpgradeCount = 0;
    projectilePowerUpgradeCount = 0;
    enemies.clear();
    projectiles.clear();
    experiencePoints.clear();
    _ticker.start();
  }

  // 적 생성 함수
  void _spawnEnemy(Size screenSize) {
    double x, y;
    if (random.nextBool()) {
      x = random.nextBool() ? -50 : screenSize.width + 50; // 왼쪽 또는 오른쪽 끝에서 생성
      y = random.nextDouble() * screenSize.height; // 랜덤한 위치에서 생성
    } else {
      x = random.nextDouble() * screenSize.width; // 랜덤한 위치에서 생성
      y = random.nextBool() ? -50 : screenSize.height + 50; // 위쪽 또는 아래쪽 끝에서 생성
    }

    // 플레이어의 현재 레벨의 적만 생성
    enemies.add(Enemy(x, y, playerLevel));
  }

  // 메인 게임 루프 - 매 프레임마다 실행
  void _gameLoop(Duration elapsed) {
    if (_isGamePaused) {
      return;
    }

    // 고정된 델타 타임 사용 (예: 1/60초)
    const fixedDeltaTime = 1 / 90;

    setState(() {
      gameTime += fixedDeltaTime;
      spawnTimer += fixedDeltaTime;
      fireTimer += fixedDeltaTime;

      // 적 생성 로직
      if (spawnTimer >= spawnInterval) {
        _spawnEnemy(MediaQuery.of(context).size);
        spawnTimer = 0;
      }

      // 발사체 생성 로직
      if (fireTimer >= fireInterval) {
        _fireProjectile(); // 발사
        fireTimer = 0; // 발사 타이머 초기화
      }

      _updatePlayerPosition();
      _updateEnemies();
      _updateProjectiles();
      _checkCollisions();
      _checkExperienceCollection();
    });
  }

  // 플레이어 위치 업데이트 및 이동 처리
  void _updatePlayerPosition() {
    if (!_isUsingJoystick) {
      // 조이스틱을 사용하지 않을 때만 키보드 입력 처리
      if (_pressedKeys.contains(LogicalKeyboardKey.arrowLeft)) {
        velocityX -= moveSpeed;
      }
      if (_pressedKeys.contains(LogicalKeyboardKey.arrowRight)) {
        velocityX += moveSpeed;
      }
      if (_pressedKeys.contains(LogicalKeyboardKey.arrowUp)) {
        velocityY -= moveSpeed;
      }
      if (_pressedKeys.contains(LogicalKeyboardKey.arrowDown)) {
        velocityY += moveSpeed;
      }
      velocityX = velocityX.clamp(-maxSpeed, maxSpeed);
      velocityY = velocityY.clamp(-maxSpeed, maxSpeed);
      velocityX *= friction;
      velocityY *= friction;
      if (velocityX.abs() < 0.1) velocityX = 0; // 속도가 매우 작아지면 0으로 설정
      if (velocityY.abs() < 0.1) velocityY = 0; // 속도가 매우 작아지면 0으로 설정
    }

    setState(() {
      playerX += velocityX;
      playerY += velocityY;
      playerX = playerX.clamp(
          0, MediaQuery.of(context).size.width - 50); // 플레이어가 화면 밖으로 나가지 않도록 제한
      playerY = playerY.clamp(0,
          MediaQuery.of(context).size.height - 50); // 플레이어가 화면 밖으로 나가지 않도록 제한
    });
  }

  // 적  업데이트 및 관리
  void _updateEnemies() {
    for (var enemy in enemies) {
      if (enemy.isActive) {
        enemy.moveTowardsPlayer(playerX, playerY); // 플레이어를 향해 이동
      }
    }
    enemies.removeWhere((enemy) => !enemy.isActive); // 비활성화된 적 제거
  }

  // 사체 위치 업데이트 및 관리
  void _updateProjectiles() {
    for (var projectile in projectiles) {
      if (projectile.isActive) {
        projectile.move();
        if (projectile.x < 0 ||
            projectile.y < 0 ||
            projectile.x > MediaQuery.of(context).size.width ||
            projectile.y > MediaQuery.of(context).size.height) {
          projectile.isActive = false; // 화면 밖으로 나가면 비활성화
        }
      }
    }
    projectiles
        .removeWhere((projectile) => !projectile.isActive); // 비활성화된 발사체 제거
  }

  // 충돌 지 (플레이어-적, 발사체-적)
  void _checkCollisions() {
    for (var enemy in enemies) {
      if (enemy.isActive && enemy.checkCollision(playerX, playerY)) {
        _handleCollision(enemy);
      }
      for (var projectile in projectiles) {
        if (projectile.isActive && projectile.checkCollision(enemy)) {
          setState(() {
            enemy.health -= projectile.power.toInt();
            projectile.isActive = false;
            if (enemy.health <= 0) {
              enemy.isActive = false;
              // 경험치 아이템 생성 로직
              final dropChance = random.nextDouble();
              if (dropChance < 0.1) {
                // 10% 확률로 녹색(3배) 경험치
                experiencePoints
                    .add(ExperiencePoint(Offset(enemy.x, enemy.y), true));
              } else if (dropChance < 0.8) {
                // 70% 확률로 노란색(1배) 경험치
                experiencePoints
                    .add(ExperiencePoint(Offset(enemy.x, enemy.y), false));
              }
            }
          });
        }
      }
    }
  }

  // 플레이어와 적 충돌 시 처리
  void _handleCollision(Enemy enemy) {
    setState(() {
      playerHealth -= 10;
      if (playerHealth <= 0) {
        _gameOver();
      }
    });
    final dx = playerX - enemy.x;
    final dy = playerY - enemy.y;
    final distance = math.sqrt(dx * dx + dy * dy);
    if (distance > 0) {
      velocityX += (dx / distance) * 10; // 플레이어 속도 조절
      velocityY += (dy / distance) * 10; // 플레이어 속도 조절
    }
  }

  // 발사체 생성 및 발사
  void _fireProjectile() {
    if (enemies.isEmpty) return;
    // 가장 가까운 적 찾기
    Enemy? closestEnemy;
    double closestDistance = double.infinity;
    for (var enemy in enemies) {
      if (enemy.isActive) {
        final dx = enemy.x - playerX;
        final dy = enemy.y - playerY;
        final distance = math.sqrt(dx * dx + dy * dy);
        if (distance < closestDistance) {
          closestDistance = distance;
          closestEnemy = enemy;
        }
      }
    }
    if (closestEnemy != null) {
      final dx = closestEnemy.x - playerX;
      final dy = closestEnemy.y - playerY;
      final angle = math.atan2(dy, dx);
      for (int i = 0; i < projectileCount; i++) {
        // 각 발사체에 약간의 각도 변화를 주어 퍼지게 함
        final spreadAngle =
            angle + (i - (projectileCount - 1) / 2) * 0.1; // 각도 변화
        projectiles.add(Projectile(
          x: playerX,
          y: playerY,
          speed: 6.0, // 발사체 속도
          angle: spreadAngle, // 각도 변화
          power: projectilePower, // 발사체 데미지
        ));
      }
    }
  }

  // 경험치 아이템 수집 확인
  void _checkExperienceCollection() {
    experiencePoints.removeWhere((exp) {
      final dx = exp.position.dx - (playerX + 25);
      final dy = exp.position.dy - (playerY + 25);
      final distance = math.sqrt(dx * dx + dy * dy);
      if (distance < 30) {
        experienceCollected += exp.value;
        if (experienceCollected >= experienceNeeded) {
          playerLevel++;
          experienceCollected = 0;
          experienceNeeded += 5 + playerLevel;
          _showUpgradeOptions();
        }
        return true;
      }
      return false;
    });
  }

  // 레벨업 시 업그레이드 옵션 표시
  void _showUpgradeOptions() {
    setState(() {
      _isGamePaused = true;
      velocityX = 0;
      velocityY = 0;
      _pressedKeys.clear();

      // 레벨업 시 난이도 조정
      _adjustDifficulty();
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('업그레이드 선택'),
        content: const Text('다음 중 하나를 선택하세요:'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                fireInterval = math.max(0.1, fireInterval * 0.9);
                fireRateUpgradeCount++;
                upgradeCount++;
                _isGamePaused = false;
                _pressedKeys.clear(); // 키 입력 상태 다시 한번 초기화
              });
              Navigator.of(context).pop();
            },
            child: const Text('발사 속도 증가'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                projectileCount++;
                projectileCountUpgradeCount++;
                upgradeCount++;
                _isGamePaused = false;
              });
              Navigator.of(context).pop();
            },
            child: const Text('발사 개수 증가'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                projectilePower += 1.0;
                projectilePowerUpgradeCount++;
                upgradeCount++;
                _isGamePaused = false;
              });
              Navigator.of(context).pop();
            },
            child: const Text('발사 파워 증가'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                playerHealth = maxPlayerHealth; // Fully heal to max health
                upgradeCount++;
                _isGamePaused = false;
              });
              Navigator.of(context).pop();
            },
            child: const Text('체력 회복'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                maxPlayerHealth += 50;
                playerHealth = (playerHealth + 5).clamp(
                    0, maxPlayerHealth); // Increase max health and heal by 5
                upgradeCount++;
                _isGamePaused = false;
              });
              Navigator.of(context).pop();
            },
            child: const Text('최대 체력 증가'),
          ),
        ],
      ),
    );
  }

  // 새로운 메서드 추가
  void _adjustDifficulty() {
    // 레벨에 따라 적 생성 간격 감소 (0.05초씩)
    // 최소 0.5초까지만 감소하도록 제한
    spawnInterval = math.max(0.5, 1.7 - ((playerLevel - 1) * 0.03));
  }

  // 게임 오버 처리
  void _gameOver() {
    _ticker.stop();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('게임 오버'),
        content: const Text('다시 시도하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _restartGame();
            },
            child: const Text('재시작'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false,
              );
            },
            child: const Text('홈으로'),
          ),
        ],
      ),
    );
  }

  // 게임 재시작
  void _restartGame() {
    setState(() {
      // 모든 게임 변수 초기화
      playerX = 100.0;
      playerY = 100.0;
      velocityX = 0.0;
      velocityY = 0.0;
      playerHealth = 100.0;
      maxPlayerHealth = 100.0;
      playerLevel = 1;
      experienceCollected = 0;
      experienceNeeded = 10;
      projectileCount = 1;
      projectilePower = 1.0;
      fireInterval = 0.5;
      spawnInterval = 1.7;
      gameTime = 0.0;
      upgradeCount = 0;
      fireRateUpgradeCount = 0;
      projectileCountUpgradeCount = 0;
      projectilePowerUpgradeCount = 0;
      _isGamePaused = false;
      _pressedKeys.clear();

      // 게임 오브젝트 초기화
      enemies.clear();
      projectiles.clear();
      experiencePoints.clear();

      // 타이머 관련 변수 초기화
      spawnTimer = 0;
      fireTimer = 0;

      // 게임 루프 재시작
      if (!_ticker.isActive) {
        _ticker.start();
      }
    });
  }

  // 게임 일시정지
  void _pauseGame() {
    setState(() {
      _isGamePaused = true;
    });
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('일시정지'),
        content: const Text('게임을 계속하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _isGamePaused = false; // 게임 상태를 재개로 변경
                if (!_ticker.isActive) {
                  _ticker.start(); // 티커 재시작
                }
              });
            },
            child: const Text('계속'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _restartGame();
            },
            child: const Text('재시작'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false,
              );
            },
            child: const Text('홈으로'),
          ),
        ],
      ),
    );
  }

  // 리소스 정리
  @override
  void dispose() {
    _ticker.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // UI 구성
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            playerX += details.delta.dx;
            playerY += details.delta.dy;
            playerX = playerX.clamp(0, MediaQuery.of(context).size.width - 50);
            playerY = playerY.clamp(0, MediaQuery.of(context).size.height - 50);
          });
        },
        child: Container(
          color: Colors.black,
          child: RawKeyboardListener(
            focusNode: _focusNode,
            autofocus: true,
            onKey: (RawKeyEvent event) {
              if (event is RawKeyDownEvent) {
                _pressedKeys.add(event.logicalKey);
              } else if (event is RawKeyUpEvent) {
                _pressedKeys.remove(event.logicalKey);
              }
            },
            child: Stack(
              children: [
                Positioned(
                  right: 10,
                  top: 10,
                  child: ElevatedButton(
                    onPressed: _pauseGame,
                    child: const Text('Pause'),
                  ),
                ),
                Positioned(
                  left: playerX,
                  top: playerY,
                  child: widget.imageBytes != null
                      ? ClipOval(
                          child: Image.memory(
                            widget.imageBytes!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                        ),
                ),
                ...enemies.map((enemy) => Positioned(
                      left: enemy.x,
                      top: enemy.y,
                      child: Column(
                        children: [
                          Text(
                            '${enemy.health}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: enemy.color,
                                width: 2,
                              ),
                            ),
                            child: enemy.level <= widget.enemyImageBytes.length
                                ? ClipOval(
                                    child: Image.memory(
                                      widget.enemyImageBytes[enemy.level - 1],
                                      width: 30,
                                      height: 30,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: enemy.color,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    )),
                ...projectiles.map((projectile) => Positioned(
                      left: projectile.x,
                      top: projectile.y,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Colors.yellow,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )),
                ...experiencePoints.map((exp) => Positioned(
                      left: exp.position.dx,
                      top: exp.position.dy,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: exp.color,
                          shape: BoxShape.rectangle,
                        ),
                      ),
                    )),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 150,
                        height: 20,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: playerHealth / 100,
                            backgroundColor: Colors.grey,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      Text(
                        '${playerHealth.toInt()}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Enemies: ${enemies.where((enemy) => enemy.isActive).length}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 5), // Consistent spacing
                      Text(
                        'Health: ${playerHealth.toStringAsFixed(1)}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 5), // Consistent spacing
                      Text(
                        'Level: $playerLevel',
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 5), // Consistent spacing
                      Text(
                        'Experience: $experienceCollected/$experienceNeeded',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 10,
                  left: MediaQuery.of(context).size.width / 2 - 50,
                  child: Text(
                    '시간: ${gameTime.toInt()}초', // Display time as integer
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Text(
                    '발사 속도 증가: $fireRateUpgradeCount\n'
                    '발사 개수 증가: $projectileCountUpgradeCount\n'
                    '발사 파워 증가: $projectilePowerUpgradeCount',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
