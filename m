Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:44652 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752734AbcCJQ4s (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 10 Mar 2016 11:56:48 -0500
Subject: Re: [PATCH bluetooth-next] mac802154: LED trigger support
References: <1454356810-5600-1-git-send-email-koen@bergzand.net>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <56E1A74C.2070104@osg.samsung.com>
Date: Thu, 10 Mar 2016 17:56:44 +0100
MIME-Version: 1.0
In-Reply-To: <1454356810-5600-1-git-send-email-koen@bergzand.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Koen Zandberg <koen@bergzand.net>, linux-wpan@vger.kernel.org

Hello.

On 01/02/16 21:00, Koen Zandberg wrote:
> Hello,
>
> This contains a patch to the mac802154 code for LED trigger support. Two LED
> triggers are added, one for tx events and one for rx events. Trigger names are
> based on the physical device name appended with the function, for example
> "phy0-tx".
> The patches are heavily based on the mac80211 led support.
>
>
>
> This commit adds LED support for transmit and receive events of the
> mac802154 module. A config option is added for the LED triggers
>
> Signed-off-by: Koen Zandberg <koen@bergzand.net>
>

Did you have a chance to work on this again?

regards
Stefan Schmidt
