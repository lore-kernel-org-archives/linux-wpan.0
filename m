Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:35552 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbbDCStU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 3 Apr 2015 14:49:20 -0400
Received: by widdi4 with SMTP id di4so114890170wid.0
        for <linux-wpan@vger.kernel.org>; Fri, 03 Apr 2015 11:49:19 -0700 (PDT)
Date: Fri, 3 Apr 2015 20:49:16 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 6lowpan on a RPi using at86rf233
Message-ID: <20150403184914.GC773@omega>
References: <20150403143647.GA6266@bogon.m.sigxcpu.org>
 <20150403144459.GA773@omega>
 <20150403182744.GA8360@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150403182744.GA8360@bogon.m.sigxcpu.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Cc: linux-wpan@vger.kernel.org

On Fri, Apr 03, 2015 at 08:27:44PM +0200, Guido Günther wrote:
> On Fri, Apr 03, 2015 at 04:45:02PM +0200, Alexander Aring wrote:
> > On Fri, Apr 03, 2015 at 04:36:47PM +0200, Guido Günther wrote:
> > > Hi,
> > > I'm trying to get 6lowpan to work using bluetooth-next on the above
> > > hardware[1]. I'm currently using bluetooth-next as of
> > > baf880a96859cca79208122e555e7efeabd16e4d . When I do a:
> > > 
> > >    iwpan dev wpan0 set pan_id 0xbeef
> > > 
> > > I get:
> > > 
> > >    command failed: Device or resource busy (-16)
> > > 
> > 
> > you can set the pan_id when you interface is down only.
> 
> There was an ifplugd on the pi which continued to up the device -
> damnit. Sorry for the noise. I can now ping the two devices but am
> seeing massive packet loss:
> 
>     # ping6 -s 20   -I lowpan0  fe80::f836:9287:905c:a684 
>     PING fe80::f836:9287:905c:a684(fe80::f836:9287:905c:a684) from fe80::cb23:b779:742d:4fd2 lowpan0: 20 data bytes
>     28 bytes from fe80::f836:9287:905c:a684: icmp_seq=3 ttl=64 time=27.7 ms
>     28 bytes from fe80::f836:9287:905c:a684: icmp_seq=4 ttl=64 time=12.7 ms
>     28 bytes from fe80::f836:9287:905c:a684: icmp_seq=5 ttl=64 time=12.7 ms
>     ^C
>     --- fe80::f836:9287:905c:a684 ping statistics ---
>     16 packets transmitted, 3 received, 81% packet loss, time 15017ms
> 
> Will need to dig into this again.
> 

ah, maybe I know why. Did you use the openlabs dts at86rf233 entry?

Try this:

&spi {
	status = "okay";
	at86rf233@0 {
		compatible = "atmel,at86rf233";
		spi-max-frequency = <7500000>;
		reg = <0>;
		interrupts = <23 4>;
		interrupt-parent = <&gpio>;
		reset-gpio = <&gpio 24 1>;
		sleep-gpio = <&gpio 25 1>;
		xtal-trim = /bits/ 8 <0x0F>;
	};
};


The openlabs entry uses a clock ~ 500kHz I experience similar issues with
such a low clock. Also the xtal-trim should be "somewhat correct" for the
openlabs transceivers. I need HF equipment to really test this value  I
supposed datasheet values.

- Alex
