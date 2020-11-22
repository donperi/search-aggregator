export const mockMediaQuery = matches => {
  window.matchMedia = jest.fn().mockImplementation(
    query => {
      return {
        matches,
        media: query,
        onchange: null,
        addListener: jest.fn(),
        removeListener: jest.fn()
      };
    }
  );
};
