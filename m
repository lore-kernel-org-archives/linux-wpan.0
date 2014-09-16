Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from p3plsmtpa11-02.prod.phx3.secureserver.net ([68.178.252.103]:59626
	"EHLO p3plsmtpa11-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752098AbaIPUNH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Tue, 16 Sep 2014 16:13:07 -0400
Message-ID: <541899D8.4020101@componentsw.com>
Date: Tue, 16 Sep 2014 13:13:12 -0700
From: Walter Mack <wmack@componentsw.com>
MIME-Version: 1.0
Subject: Re: [PATCH wpan-next] ieee802154: mrf24j40: support for external
 rx/tx
References: <1410759338-21663-1-git-send-email-wmack@componentsw.com> <20140916070156.GB1244@omega>
In-Reply-To: <20140916070156.GB1244@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, alan@signal11.us, simon.vincent@xsilon.com

Alex,

this is not a question of chip revisions. Chips with the same revision 
can be used in designs with or without the external 
transmitter/receiver. Its just that the chip has to be set up to be 
compatible with the design.

On 09/16/2014 12:01 AM, Alexander Aring wrote:
> Alan,
>
> ping?
>
> This looks for me like what Simon Vincent has send about a month ago.
>
> I like more to check on chip revision instead setting module parameter,
> but you have the last word.
>
> Please, handle this in any way which you like. I see now there comming
> more patches for the same issue, I don't like that. We should add
> support for this.
>
> - Alex
>

