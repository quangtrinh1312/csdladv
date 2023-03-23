import axiosClient from "./axiosClient";

export const category = {
  movie: "movie",
  tv: "tv",
};

export const movieType = {
  upcoming: "upcoming",
  popular: "popular",
  top_rated: "top_rated",
  trending : "trending"
};

export const tvType = {
  popular: "popular",
  top_rated: "top_rated",
  on_the_air: "on_the_air",
};

const tmdbApi = {
  getMoviesList: (type, params) => {
    let url = "movie/" + movieType[type];
    if(type === "trending") url = "trending/movie/week";
    console.log(url);
    return axiosClient.get(url, params);
  },
  getTvList: (type, params) => {
    let url = "tv/" + tvType[type];
    if(type === "trending") url = "trending/tv/week";
    return axiosClient.get(url, params);
  },
  getGenres: (params) => {
    const url = "genre/movie/list";
    return axiosClient.get(url, params);
  },
};

export default tmdbApi;
