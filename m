Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:51324 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752137AbcDTPfJ (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 20 Apr 2016 11:35:09 -0400
Subject: Re: IEEE802.15.4 devices
References: <1901820321.4428741461165958512.JavaMail.httpd@fep-webmail-11.iol.local>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <5717A1A9.30002@osg.samsung.com>
Date: Wed, 20 Apr 2016 17:35:05 +0200
MIME-Version: 1.0
In-Reply-To: <1901820321.4428741461165958512.JavaMail.httpd@fep-webmail-11.iol.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "gianni.frigerio90@virgilio.it" <gianni.frigerio90@virgilio.it>, linux-wpan@vger.kernel.org

Hello.

On 20/04/16 17:25, gianni.frigerio90@virgilio.it wrote:
> Hi all,
> I am starting to work on IEEE802.15.4 technology,
> and I am looking for possible hardware solutions
> to be used with embedded devices based on Linux.

http://wpan.cakelab.org/#_supported_hardware

would be a good start for you.
>   
> Surfing on the web I found these two solutions to be
> easily used with the BeagleBone Black:
> http://ngs-sensors.it/shop/ngs-iot-mchp/
> http://ngs-sensors.it/shop/ngs-iot-atmel/

High prices I would say. If you don't mind a little soldering you can 
add the mrf24j40ma to your embedded board easily enough.
For the atmel side there is a ready made module from openlabs which 
quite a few people are using:
http://openlabs.co/store/Raspberry-Pi-802.15.4-radio

In general getting one of the modules hooked up with the pon headers of 
your board of choice should be ok.
> Do you have experience on that? Is someone
> using such a components?

The mrf24j40 transceiver is supported mainline. For the board with the 
atmel chip I would need to know the actual transceiver being used. But 
we support almost all of them (IIRC only 215 is missing but hopefully 
being worked on)

regards
Stefan Schmidt
