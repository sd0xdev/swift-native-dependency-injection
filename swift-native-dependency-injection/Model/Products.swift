/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Products : Codable {
	let _id : String?
	let created : String?
	let name : String?
	let owner : String?
	let description : String?
	let image : String?
	let category : String?
	let __v : Int?

	enum CodingKeys: String, CodingKey {

		case _id = "_id"
		case created = "created"
		case name = "name"
		case owner = "owner"
		case description = "description"
		case image = "image"
		case category = "category"
		case __v = "__v"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		_id = try values.decodeIfPresent(String.self, forKey: ._id)
		created = try values.decodeIfPresent(String.self, forKey: .created)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		owner = try values.decodeIfPresent(String.self, forKey: .owner)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		image = try values.decodeIfPresent(String.self, forKey: .image)
		category = try values.decodeIfPresent(String.self, forKey: .category)
		__v = try values.decodeIfPresent(Int.self, forKey: .__v)
	}

}