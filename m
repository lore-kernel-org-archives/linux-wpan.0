Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:47531 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973AbaIHKnc (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 8 Sep 2014 06:43:32 -0400
Received: by mail-wg0-f51.google.com with SMTP id k14so487533wgh.10
        for <linux-wpan@vger.kernel.org>; Mon, 08 Sep 2014 03:43:31 -0700 (PDT)
Date: Mon, 8 Sep 2014 12:43:28 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 6lowpan raw socket problems
Message-ID: <20140908104326.GC6981@omega>
References: <1409638090.3120.71.camel@jrissane-mobl.ger.corp.intel.com>
 <20140902071214.GA25800@omega>
 <20140902072627.GB25800@omega>
 <5405D284.7020606@xsilon.com>
 <20140902144327.GA15189@omega>
 <5405D961.4060006@xsilon.com>
 <20140902153742.GC15189@omega>
 <5405EB08.5040006@xsilon.com>
 <20140902162630.GD15189@omega>
 <5406123E.2080100@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5406123E.2080100@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: Simon Vincent <simon.vincent@xsilon.com>, linux-wpan@vger.kernel.org

On Tue, Sep 02, 2014 at 07:53:50PM +0100, Martin Townsend wrote:
> On 02/09/14 17:26, Alexander Aring wrote:
> >On Tue, Sep 02, 2014 at 05:06:32PM +0100, Simon Vincent wrote:
> >>This is not a problem. There is a fix elsewhere for that.
> >>
> >>I am using local-link addresses.
> >>
> >>I am seeing funny things like:
> >>lowpan0: received packet from fe80::203:9a00:41:c864 ->
> >>7707:ffff:300:0:9a:300:7b3b:3a1a
> >>
> >>Src address fe80::203:9a00:41:c864 does not exist on the network and
> >>destination address 7707:ffff:300:0:9a:300:7b3b:3a1a does not.
> >>
> >Where do you capture this? You know that wireshark on a lowpan interface
> >is broken?
> >
> >- Alex
> >--
> >To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Hi Alex,
> 
> I'm working with Simon and these are from printf statements, we've stepped
> through the code and seen the same problem.
> 
> It would be nice to have a better testing environment, you mentioned that
> you have a virtual setup, does this allow for multiple nodes sending
> receiving packets like the contiki one? if so do you have instructions on
> how to setup?
> 

for testing you could use fakelb or tony's serial virtual interface [0].
I didn't test both of them, but we need some testing interface of
course.

The virtual serial interface require the serial driver.

Sorry for my late reply.

[0] https://github.com/tcheneau/virtual-ieee802154-serial
