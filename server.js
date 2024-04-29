const { createServer } = require('@backstage/backend');
const { Logger } = require('@backstage/backend-common');

async function main() {
  const logger = Logger.child({ namespace: 'app' });

  const server = await createServer({
    logger,
    // Other configuration options
  });

  await server.listen();
  logger.info(`Server listening on port ${server.port}`);
}

main().catch(error => {
  console.error('Error starting the server:', error);
  process.exit(1);
});
