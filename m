Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37336 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbcCFKSR (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 6 Mar 2016 05:18:17 -0500
Received: by mail-wm0-f51.google.com with SMTP id p65so39060149wmp.0
        for <linux-wpan@vger.kernel.org>; Sun, 06 Mar 2016 02:18:16 -0800 (PST)
Date: Sun, 6 Mar 2016 11:17:33 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 802.15.4G support?
Message-ID: <20160306101659.GA625@omega>
References: <CAH+RWqF-3Q8P52PTM9ZqpybEWTCKiubQK0-Y7L=c-3vAMhJfrg@mail.gmail.com>
 <20160228140659.GA17980@omega>
 <28981.1457015214@obiwan.sandelman.ca>
 <20160304083528.GA1525@omega>
 <24416.1457106776@obiwan.sandelman.ca>
 <20160304163749.GA21798@omega>
 <CAH+RWqFmxcNxtzTjkcR+Z3dmCdkB5HU-=668rmXMiVaDVZUymg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH+RWqFmxcNxtzTjkcR+Z3dmCdkB5HU-=668rmXMiVaDVZUymg@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Remi Philippe <remi@linqio.com>
Cc: linux-wpan@vger.kernel.org

Hi,

please cc linux-wpan mailinglist.

On Sun, Mar 06, 2016 at 09:32:50AM +0400, Remi Philippe wrote:
> On Fri, Mar 4, 2016 at 8:37 PM, Alexander Aring <alex.aring@gmail.com> wrote:
> > On Fri, Mar 04, 2016 at 10:52:56AM -0500, Michael Richardson wrote:
> >> Alexander Aring <alex.aring@gmail.com> wrote:
> >>     > On Thu, Mar 03, 2016 at 09:26:54AM -0500, Michael Richardson wrote:
> >>     >> Alexander Aring <alex.aring@gmail.com> wrote: > You want to run
> >>     >> 6LoWPAN on it, current the 802.15.4 calculates a lot of > stuff with
> >>     >> the IEEE802154_MTU define, in most cases when using > fragmentation.
> >>     >>
> >>     >> > It seems you don't need fragmentation in your case, because you
> >>     >> reach > the 1280 minimum MTU for IPv6. The condition at [4] should be
> >>     >> always > true then.
> >>     >>
> >>     >> I believe that they do, as 15.4g PHYs can communicate with 15.4 PHYs,
> >>     >> and so the fragment on/off/MTU decision will need to be added to the
> >>     >> neighbour cache.
> >>
> >>
> >>     > Okay, this really scares me now. You say that the these "SUN PHY's" use
> >>     > the same modulation/band/preamble and can probaly talk with all other
> >>     > PHY's.
> >>
> >> Yes, that's my belief.
> >> Maybe they don't use the same modulation when they send bigger frames, but
> >> they can speak to 15.4-noletter,/15.4e.
> >> (Note: 802.15.4-2015 includes all of e, and I think, all of the g work too,
> >> making it harder to know which is which when speaking)
> >>
> >
> > ok.
> 
> 
> I believe modulation is always different, from the 802.15.4-2011 spec
> the supported modulations are : O-QPSK, BPSK, ASK, CSS, UWB, MPSK and
> GFSK while for 802.15.4g-2012 they are: MR-FSK, MR-OFDM and MR-O-QPSK.
> From the chips datasheet, they only support a subset for 15.4 / 15.4g,
> for example AT86RF215 only supports MR-FSK, MR-O-QPSK and O-QPSK.
> 
> Maybe I'm missing something but I wouldn't expect to chip to process
> frames for a modulation it's not configured on.
> 

Looking again into 802.15.4g-2012 there stands on page (not pdf page)
95:

"For the 780 MHz, 915 MHz, and 2450 MHz frequency bands, the MR-O-QPSK
 PHY supports communication with legacy devices according to the
 specifications in Clause 10, as described in 18.3.3."

so somewhat with "Clause 10" and at 18.3.3 the standard says:

"18.3.3 Support of legacy devices of the 780 MHz, 915 MHz, and 2450 MHz
 O-QPSK PHYs" ... the lot of copy&pasting witht the same sentences but
 different frequencies. :-)

Then looking into 802.15.4-2011 for Clause 10, the standard says:

"10. O-QPSK PHY"

so Clause 10, they mean all other PHYs. For me it looks like it is
possible to communicate with "legacy device according to the
specifications in Clause 10".

MR-O-QPSK is compatible with O-QPSK.

So the question is also when using the other modulations. At first for
supporting also the "legacy device" it should be O-QPSK. But then there
is some mechanism and the neighbor need to know "it supports these
modulations and this MTU".

> >
> >>     >> > Another question would be: You can run 6LoWPAN on it, but nobody >
> >>     >> specifies to run 6LoWPAN on such "SUN PHY's". I actually don't see >
> >>     >> that. Everything is specified with 127 MTU.
> >>     >>
> >>     >> > I don't want to tell you cannot run 6LoWPAN on it, but does somebody
> >>     >> > need to specify 6LoWPAN for 802.15.4g at first?
> >>     >>
> >>     >> WiSun alliance did that, I think.
> >>     >>
> >>
> >>     > ok. Then the above situation about handling with "SUN PHYs" and all
> >>     > other PHYs need to be specified there, or?
> >>
> >>     > And another question is: Is that an open standard?
> >>
> >> https://www.wi-sun.org/ seems relatively open, it's just 802.15.4g, I think.
> >> And https://datatracker.ietf.org/doc/draft-ietf-roll-applicability-ami/
> >> is mostly about 4g.
> >>
> >
> > Okay. I think at first normal 127-bytes frames need to be send. After if
> > you are sure that your "neighbor" uses a "SUN Phy" then you need to
> > change the MTU (during runtime) for this special neighbor so a different
> > handling can be done.
> >
> > Depends if you really want such handling as default behaviour.
> >
> > Something like that, but I am not sure how it really would working and
> > don't know how the "indentification it's a SUN Phy or not will work",
> > the MAC frame format has some extensions with "capabilities" maybe
> > somehow while parsing mac frame in L2 which indicates the transmitted
> > node as a "SUN Phy".
> >
> > Maybe there exists also a L3 mechanism to indicate a "SUN Phy", e.g.
> > an Option-Field. (I would more like such handling than that the L2 header
> > indicates it somehow). I suppose the right website to lookup such thing
> > is [0], but didn't find anything related to that.
> >
> > (about fragmentation handling for 4g):
> > The [1] say something about that fragmentation/reassembly is not
> > necessary when using 2048 frames. :-)
> >
> 
> Nivis (http://www.nivis.com/) is using 6loWPAN on 802.15.4g for
> example (apparently on a Linux 3.2 kernel if I believe the specs)
> 

Okay, maybe they don't use the 6LoWPAN/802.15.4 Implementation of the
Linux-Kernel.

Maybe they do the SLIP way and the external device with firmware do the
6LoWPAN adapation. Look at my slides [0] to understand the difference.
Slides 11-12.

I can't see it at layer-graphic [1] and board graphic [2].

They write that they using linux, maybe ask for the kernel sources?

- Alex

[0] http://www.netdevconf.org/1.1/proceedings/slides/aring-generic-6lowpan-branch.pdf
[1] http://www.nivis.com/resources/Smart%20Object%20Solution%20Brief.pdf
[2] http://www.nivis.com/products/images/products/VR1100/IMG_4450.jpg
