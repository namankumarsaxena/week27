FROM oven/bun:1

WORKDIR /usr/src/app

COPY ./packages ./packages
COPY ./bun.lock ./bun.lock
COPY ./package.json ./package.json
COPY ./turbo.json ./turbo.json
COPY ./apps/ws ./apps/ws

COPY . .

RUN bun install
RUN cd packages/db && \
    DATABASE_URL="postgresql://user:password@localhost:5432/placeholder" \
    bunx prisma generate

EXPOSE 8081

CMD [ "bun", "run", "start:ws" ]