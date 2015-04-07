Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from photon.sigxcpu.org ([95.142.169.183]:36666 "EHLO
	photon.sigxcpu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753705AbbDGLtZ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Apr 2015 07:49:25 -0400
Date: Tue, 7 Apr 2015 13:49:21 +0200
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Subject: Re: 6lowpan on a RPi using at86rf233
Message-ID: <20150407114921.GA3390@bogon.m.sigxcpu.org>
References: <20150403143647.GA6266@bogon.m.sigxcpu.org>
 <20150403144459.GA773@omega>
 <20150403182744.GA8360@bogon.m.sigxcpu.org>
 <20150403183804.GB773@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150403183804.GB773@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Fri, Apr 03, 2015 at 08:38:06PM +0200, Alexander Aring wrote:
> On Fri, Apr 03, 2015 at 08:27:44PM +0200, Guido Günther wrote:
> > On Fri, Apr 03, 2015 at 04:45:02PM +0200, Alexander Aring wrote:
> > > On Fri, Apr 03, 2015 at 04:36:47PM +0200, Guido Günther wrote:
> > > > Hi,
> > > > I'm trying to get 6lowpan to work using bluetooth-next on the above
> > > > hardware[1]. I'm currently using bluetooth-next as of
> > > > baf880a96859cca79208122e555e7efeabd16e4d . When I do a:
> > > > 
> > > >    iwpan dev wpan0 set pan_id 0xbeef
> > > > 
> > > > I get:
> > > > 
> > > >    command failed: Device or resource busy (-16)
> > > > 
> > > 
> > > you can set the pan_id when you interface is down only.
> > 
> > There was an ifplugd on the pi which continued to up the device -
> > damnit. Sorry for the noise. I can now ping the two devices but am
> > seeing massive packet loss:
> 
> This "ifplugd" thing is a common issue, most people which using raspbian
> reported similar issues.

I've documented this at [1] so hopefully Google helps to avoid this a bit.

> 
> > 
> >     # ping6 -s 20   -I lowpan0  fe80::f836:9287:905c:a684 
> >     PING fe80::f836:9287:905c:a684(fe80::f836:9287:905c:a684) from fe80::cb23:b779:742d:4fd2 lowpan0: 20 data bytes
> >     28 bytes from fe80::f836:9287:905c:a684: icmp_seq=3 ttl=64 time=27.7 ms
> >     28 bytes from fe80::f836:9287:905c:a684: icmp_seq=4 ttl=64 time=12.7 ms
> >     28 bytes from fe80::f836:9287:905c:a684: icmp_seq=5 ttl=64 time=12.7 ms
> >     ^C
> >     --- fe80::f836:9287:905c:a684 ping statistics ---
> >     16 packets transmitted, 3 received, 81% packet loss, time 15017ms
> > 
> > Will need to dig into this again.
> >
> 
> mhh, is this a linux to linux connection? Maybe try to activate ARET
> mode, you can do that with:

Linux to Linux, yes. Thought that this is simpler before trying to talk
to Contiki.

> 
> iwpan dev wpan0 set max_frame_retries 3
> 
> or something differs with 3, -1 will turn off the ARET mode. Value 0
> will do csma handling only. All above 0 will do retransmission tries.
> You should do that on both nodes and all nodes in your network need to
> support AACK handling. (Automatck ACK).
> 
> Or maybe switch channel, I am running out of ideas now. :-)

I turned out that the 1.5 meters with some metal in the walls was far
too much of a faraday cage for that module (altough it isn't a problem
for 802.11). Moving things closer together made the packet loss mostly
go away.

Cheers,
 -- Guido




[1] https://honk.sigxcpu.org/piki/hw/rpi6lowpan/
