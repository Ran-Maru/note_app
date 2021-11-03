// TODO: DOMAINをソース直書きではなく、外部から指定する方式に変更する。
const DOMAIN = 'http://localhost:3000/'
const API_BASE = DOMAIN + 'api/v1/'

const API = {
  NOTES: API_BASE + 'notes/',
  NOTES_TRASH: API_BASE + 'notes/trash/',
  LABELS: API_BASE + 'labels/',
  LABELINGS: API_BASE + 'labelings/',
  LABELINGS_DESTROY: API_BASE + 'labelings/destroy/'
}

Object.freeze(API)

export { API }