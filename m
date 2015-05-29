Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37209 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755563AbbE2JLi (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 29 May 2015 05:11:38 -0400
Received: by wifw1 with SMTP id w1so15460396wif.0
        for <linux-wpan@vger.kernel.org>; Fri, 29 May 2015 02:11:36 -0700 (PDT)
Date: Fri, 29 May 2015 11:11:33 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC] the problem of on-the-wire byte order in ieee802154
Message-ID: <20150529091129.GB3709@omega>
References: <20150528140934.GG11340@wantstofly.org>
 <20150528162702.785e1f1c@zoidberg>
 <20150529041723.GN11340@wantstofly.org>
 <20150529074419.GA2557@omega>
 <20150529080821.GO11340@wantstofly.org>
 <20150529083145.GA3709@omega>
 <55682914.6060109@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55682914.6060109@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>, Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>, linux-wpan@vger.kernel.org

Hi Simon,

On Fri, May 29, 2015 at 09:53:40AM +0100, Simon Vincent wrote:
> I noticed the 802.15.4 spec has test vectors for the crypto that show the
> byte order of the address.
> See 802.15.4-2011 spec [1]
> Annex C, Section C.2.1.1
> 
> source address 0xacde480000000001 is represented in a packet as.
> 08 D0 84 21 43 01 00 00 00 00 48 DE AC || 02 05 00 00 00 || 55 CF 00 00 51
> 52 53 54 22 3B C1 EC 84 1A
> B5 53.
> 

thanks for this note. That shows that the LSB "01" of 0xacde480000000001 is send at
the first of the packet. Then it should be little endian, or? (In case
of this example).

- Alex
