Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from box.christofferholmstedt.se ([188.166.68.52]:47336 "EHLO
	box.christofferholmstedt.se" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753000AbbFJIY7 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Wed, 10 Jun 2015 04:24:59 -0400
Received: from authenticated-user (unknown [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by box.christofferholmstedt.se (Postfix) with ESMTPSA id 7EF42140D6B
	for <linux-wpan@vger.kernel.org>; Wed, 10 Jun 2015 04:24:55 -0400 (EDT)
Date: Wed, 10 Jun 2015 10:24:49 +0200
From: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Subject: nl802154 enum misspelled, just send patch?
Message-ID: <20150610082449.GA20831@arazu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi
While working on the CCA improvements to wpan-tools I noticed that one of the
enums has a value misspelled. As the header is not in UAPI yet I suggest we
fix this.

NL802154_CCA_UWB_MULTIPEXED is missing an l (ell) in multiplexed.

The header file is included in wpan-tools repository and available in the
kernel. Should I just send a patch for bluetooth-next and then the new header
file is copied over to wpan-tools repository or what is the procedure here?

I assume normal procedure for more "stable" user-space software is that the
kernel header file(s) should not be included in the user-space tool but instead
included and linked against the kernel headers (from running system or similiar
source). At the moment the nl802154 header is included in wpan-tools to make it
easier to build while developing.

So, should I send a patch for both bluetooth-next and wpan-tools or just
bluetooth-next?

Regards
-- 
Christoffer Holmstedt
