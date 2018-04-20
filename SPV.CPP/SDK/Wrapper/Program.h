// Copyright (c) 2012-2018 The Elastos Open Source Project
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef __ELASTOS_SDK_PROGRAM_H__
#define __ELASTOS_SDK_PROGRAM_H__

#include <boost/shared_ptr.hpp>

#include "ByteData.h"
#include "ELAMessageSerializable.h"

namespace Elastos {
	namespace SDK {

		class Program :
			public ELAMessageSerializable {
		public:
			Program();

			Program(const ByteData &code, const ByteData &parameter);

			~Program();

			virtual void Serialize(std::istream &istream) const;

			virtual void Deserialize(std::ostream &ostream);

		private:
			ByteData _code;
			ByteData _parameter;
		};

		typedef boost::shared_ptr<Program> ProgramPtr;

	}
}

#endif //__ELASTOS_SDK_PROGRAM_H__
