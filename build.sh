# Pull the latest builder image from remote repository
docker pull unstablectrl/app:builder || true

# Only build the 'builder' stage, using pulled image as cache
docker build \
  --build-arg BUILDKIT_INLINE_CACHE=1 \
  --target builder \
  --cache-from unstablectrl/app:builder \
  -t unstablectrl/app:builder \
  -f "Dockerfile" \
  "."

# Pull the latest runtime image from remote repository
# (This may or may not be worthwhile, depending on your exact image)

docker pull unstablectrl/app:latest || true

# Don't specify target (build whole Dockerfile)
# Uses the just-built builder image and the pulled runtime image as cache
docker build \
  --build-arg BUILDKIT_INLINE_CACHE=1 \
  --cache-from unstablectrl/app:builder \
  --cache-from unstablectrl/app:latest \
  -t unstablectrl/app:1.0.0 \
  -t unstablectrl/app:latest \
  -f "Dockerfile" \
  "."

# Push runtime images to remote repository
# docker push unstablectrl/app:1.0.0
# docker push unstablectrl/app:latest

# Push builder image to remote repository for next build
# docker push unstablectrl/app:builder
# https://andrewlock.net/caching-docker-layers-on-serverless-build-hosts-with-multi-stage-builds---target,-and---cache-from/
