Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:33188 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbbFCGeq (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 3 Jun 2015 02:34:46 -0400
Received: by wiwd19 with SMTP id d19so41102425wiw.0
        for <linux-wpan@vger.kernel.org>; Tue, 02 Jun 2015 23:34:45 -0700 (PDT)
Date: Wed, 3 Jun 2015 08:34:39 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v2 wpan-tools] info: add frequency to channel listing for
 phy capabilities
Message-ID: <20150603063436.GA731@omega>
References: <20150602075309.GA5138@probook-6560b>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150602075309.GA5138@probook-6560b>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Cc: linux-wpan@vger.kernel.org

On Tue, Jun 02, 2015 at 09:53:14AM +0200, Christoffer Holmstedt wrote:
> Add the frequency to the channel numbers output when running "iwpan list".
> The frequencies listed are according to chapter 8.1.2 in IEEE 802.15.4-2011.
> The output now looks like this (fake wpan loopback with all channels
> supported):
> 
> capabilities:
> 	iftypes: node
> 	channels:
> 		page 0:
> 			[ 0] 868.3 MHz, [ 1]   906 MHz, [ 2]   908 MHz,
> 			[ 3]   910 MHz, [ 4]   912 MHz, [ 5]   914 MHz,
> 			[ 6]   916 MHz, [ 7]   918 MHz, [ 8]   920 MHz,
> 			[ 9]   922 MHz, [10]   924 MHz, [11]  2405 MHz,
> 			[12]  2410 MHz, [13]  2415 MHz, [14]  2420 MHz,
> 			[15]  2425 MHz, [16]  2430 MHz, [17]  2435 MHz,
> 			[18]  2440 MHz, [19]  2445 MHz, [20]  2450 MHz,
> 			[21]  2455 MHz, [22]  2460 MHz, [23]  2465 MHz,
> 			[24]  2470 MHz, [25]  2475 MHz, [26]  2480 MHz
> 		page 1:
> 			[ 0] 868.3 MHz, [ 1]   906 MHz, [ 2]   908 MHz,
> 			[ 3]   910 MHz, [ 4]   912 MHz, [ 5]   914 MHz,
> 			[ 6]   916 MHz, [ 7]   918 MHz, [ 8]   920 MHz,
> 			[ 9]   922 MHz, [10]   924 MHz
> 		page 2:
> 			[ 0] 868.3 MHz, [ 1]   906 MHz, [ 2]   908 MHz,
> 			[ 3]   910 MHz, [ 4]   912 MHz, [ 5]   914 MHz,
> 			[ 6]   916 MHz, [ 7]   918 MHz, [ 8]   920 MHz,
> 			[ 9]   922 MHz, [10]   924 MHz
> 		page 3:
> 			[ 0] 2412 MHz, [ 1] 2417 MHz, [ 2] 2422 MHz,
> 			[ 3] 2427 MHz, [ 4] 2432 MHz, [ 5] 2437 MHz,
> 			[ 6] 2442 MHz, [ 7] 2447 MHz, [ 8] 2452 MHz,
> 			[ 9] 2457 MHz, [10] 2462 MHz, [11] 2467 MHz,
> 			[12] 2472 MHz, [13] 2484 MHz
> 		page 4:
> 			[ 0]  499.2 MHz, [ 1] 3494.4 MHz, [ 2] 3993.6 MHz,
> 			[ 3] 4492.8 MHz, [ 4] 3993.6 MHz, [ 5] 6489.6 MHz,
> 			[ 6] 6988.8 MHz, [ 7] 6489.6 MHz, [ 8] 7488.0 MHz,
> 			[ 9] 7987.2 MHz, [10] 8486.4 MHz, [11] 7987.2 MHz,
> 			[12] 8985.6 MHz, [13] 9484.8 MHz, [14] 9984.0 MHz,
> 			[15] 9484.8 MHz
> 		page 5:
> 			[ 0] 780 MHz, [ 1] 782 MHz, [ 2] 784 MHz,
> 			[ 3] 786 MHz, [ 4] 780 MHz, [ 5] 782 MHz,
> 			[ 6] 784 MHz, [ 7] 786 MHz
> 		page 6:
> 			[ 0] 951.2 MHz, [ 1] 951.8 MHz, [ 2] 952.4 MHz,
> 			[ 3] 953.0 MHz, [ 4] 953.6 MHz, [ 5] 954.2 MHz,
> 			[ 6] 954.8 MHz, [ 7] 955.4 MHz, [ 8] 954.4 MHz,
> 			[ 9] 954.6 MHz, [10] 951.1 MHz, [11] 951.5 MHz,
> 			[12] 951.9 MHz, [13] 952.3 MHz, [14] 952.7 MHz,
> 			[15] 953.1 MHz, [16] 953.5 MHz, [17] 953.9 MHz,
> 			[18] 954.3 MHz, [19] 954.7 MHz, [20] 955.1 MHz,
> 			[21] 955.5 MHz
> 
> Signed-off-by: Christoffer Holmstedt <christoffer@christofferholmstedt.se>

applied. Thanks.

- Alex
