Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from hmm.wantstofly.org ([148.251.232.15]:46080 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899AbbFANtQ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 1 Jun 2015 09:49:16 -0400
Date: Mon, 1 Jun 2015 16:49:15 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [RFC] the problem of on-the-wire byte order in ieee802154
Message-ID: <20150601134915.GE1897@wantstofly.org>
References: <20150528140934.GG11340@wantstofly.org>
 <20150528162702.785e1f1c@zoidberg>
 <20150529041723.GN11340@wantstofly.org>
 <20150529074419.GA2557@omega>
 <20150529080821.GO11340@wantstofly.org>
 <20150529083145.GA3709@omega>
 <55682914.6060109@xsilon.com>
 <20150529091129.GB3709@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150529091129.GB3709@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Simon Vincent <simon.vincent@xsilon.com>, Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>, linux-wpan@vger.kernel.org

On Fri, May 29, 2015 at 11:11:33AM +0200, Alexander Aring wrote:

> > I noticed the 802.15.4 spec has test vectors for the crypto that
> > show the byte order of the address.
> > See 802.15.4-2011 spec [1]
> > Annex C, Section C.2.1.1
> > 
> > source address 0xacde480000000001 is represented in a packet as.
> > 08 D0 84 21 43 01 00 00 00 00 48 DE AC || 02 05 00 00 00 || 55 CF 00 00 51
> > 52 53 54 22 3B C1 EC 84 1A
> > B5 53.
> 
> thanks for this note. That shows that the LSB "01" of
> 0xacde480000000001 is send at the first of the packet. Then it
> should be little endian, or? (In case of this example).

That's what this example suggests, yes -- as 01-00-00-00-00-48-DE-AC
would not be a valid source address, as it is a group address.  Note,
however, that Annex C is an informative annex, and not a normative
annex.

I've reached out to the IEEE for clarification of this issue, let's
see what they come up with.
