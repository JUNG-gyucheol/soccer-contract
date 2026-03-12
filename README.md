# Soccer Contract

Foundry 기반 축구 게임 Solidity 스마트 컨트랙트

## 기술 스택

- **Solidity**
- **Foundry** (빌드/테스트/배포)

## 프로젝트 구조

- `src/Soccer.sol` - 축구 게임 핵심 컨트랙트
- `src/Counter.sol` - 카운터 컨트랙트
- `script/` - 배포 스크립트
- `test/` - 테스트 코드

## 실행 방법

```bash
# 빌드
forge build

# 테스트
forge test

# 배포
forge script script/Deploy.s.sol --rpc-url <RPC_URL> --broadcast
```
