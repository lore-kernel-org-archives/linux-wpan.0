Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:35348 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300AbbFAOCB (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 1 Jun 2015 10:02:01 -0400
Received: by wicmx19 with SMTP id mx19so76685349wic.0
        for <linux-wpan@vger.kernel.org>; Mon, 01 Jun 2015 07:02:00 -0700 (PDT)
Date: Mon, 1 Jun 2015 16:01:57 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC] the problem of on-the-wire byte order in ieee802154
Message-ID: <20150601140156.GE1195@omega>
References: <20150528140934.GG11340@wantstofly.org>
 <20150528162702.785e1f1c@zoidberg>
 <20150529041723.GN11340@wantstofly.org>
 <20150529074419.GA2557@omega>
 <20150529080821.GO11340@wantstofly.org>
 <20150529083145.GA3709@omega>
 <55682914.6060109@xsilon.com>
 <20150529091129.GB3709@omega>
 <20150601134915.GE1897@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150601134915.GE1897@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Simon Vincent <simon.vincent@xsilon.com>, Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>, linux-wpan@vger.kernel.org

On Mon, Jun 01, 2015 at 04:49:15PM +0300, Lennert Buytenhek wrote:
> On Fri, May 29, 2015 at 11:11:33AM +0200, Alexander Aring wrote:
> 
> > > I noticed the 802.15.4 spec has test vectors for the crypto that
> > > show the byte order of the address.
> > > See 802.15.4-2011 spec [1]
> > > Annex C, Section C.2.1.1
> > > 
> > > source address 0xacde480000000001 is represented in a packet as.
> > > 08 D0 84 21 43 01 00 00 00 00 48 DE AC || 02 05 00 00 00 || 55 CF 00 00 51
> > > 52 53 54 22 3B C1 EC 84 1A
> > > B5 53.
> > 
> > thanks for this note. That shows that the LSB "01" of
> > 0xacde480000000001 is send at the first of the packet. Then it
> > should be little endian, or? (In case of this example).
> 
> That's what this example suggests, yes -- as 01-00-00-00-00-48-DE-AC
> would not be a valid source address, as it is a group address.  Note,
> however, that Annex C is an informative annex, and not a normative
> annex.
> 
> I've reached out to the IEEE for clarification of this issue, let's
> see what they come up with.

oh, "where" did you do that exactly?

- Alex
