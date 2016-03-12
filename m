Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from photon.sigxcpu.org ([95.142.169.183]:51356 "EHLO
	photon.sigxcpu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343AbcCLVpU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 12 Mar 2016 16:45:20 -0500
Date: Sat, 12 Mar 2016 22:38:30 +0100
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Subject: Re: testing and building for RPI
Message-ID: <20160312213830.GB6517@bogon.m.sigxcpu.org>
References: <19096.1431373298@sandelman.ca>
 <55517906.2060204@gmail.com>
 <7829.1437848841@dooku.sandelman.ca>
 <20150730173938.GA26681@bogon.m.sigxcpu.org>
 <19455.1438349620@sandelman.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19455.1438349620@sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr@sandelman.ca>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org, unstrung-hackers <unstrung-hackers@lists.sandelman.ca>

On Fri, Jul 31, 2015 at 09:33:40AM -0400, Michael Richardson wrote:
> 
> Guido Günther <agx@sigxcpu.org> wrote:
>     >> Varka Bhadram <varkabhadram@gmail.com> wrote: > You can directly use
>     >> linux-wpan-next tree directly, which has the basic > support for
>     >> RPI. No need to rebase it on rpi kernel.
>     >>
>     >> > Please see the blog: https://honk.sigxcpu.org/piki/hw/rpi6lowpan/
>     >>
>     >> I have some edits for this; mostly unfortunate typos or copy/pastes.
> 
>     > I'd be happy to apply a patch. Source is at:
> 
>     >     https://git.sigxcpu.org/cgit/ git://git.sigxcpu.org/git/piki.git
> 
> Thank you, I've checked it out, and I'll edit stuff and point you at a git
> tree.

While going through stuff for the RPI2 I noticed several typos and
updated them at:

    https://honk.sigxcpu.org/piki/hw/rpi6lowpan/

It should be a bit less confusing now.
Cheers,
 -- Guido
