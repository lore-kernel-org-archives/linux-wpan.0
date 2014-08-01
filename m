Return-Path: <linux-zigbee-devel-bounces@lists.sourceforge.net>
Date: Fri, 1 Aug 2014 11:41:46 +0200
From: Alexander Aring <alex.aring@gmail.com>
Message-ID: <20140801094144.GA11159@omega>
References: <53DB5A53.5000004@xsilon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53DB5A53.5000004@xsilon.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-zigbee-devel>,
	<mailto:linux-zigbee-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-zigbee-devel>
List-Post: <mailto:linux-zigbee-devel@lists.sourceforge.net>
List-Help: <mailto:linux-zigbee-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-zigbee-devel>,
	<mailto:linux-zigbee-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-zigbee-devel-bounces@lists.sourceforge.net
Subject: Re: [Linux-zigbee-devel] [PATCH bluetooth-next] 6lowpan: Remove
 ununsed dev parameter from skb_delivery_cb callback.
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, linux-wpan@vger.kernel.org, linux-zigbee-devel@lists.sourceforge.net
List-ID: <linux-wpan.vger.kernel.org>

Hi Martin,

On Fri, Aug 01, 2014 at 10:13:55AM +0100, Martin Townsend wrote:
> This parameter is never used by any function implementing this callback.
> ---
>  include/net/6lowpan.h         | 2 +-
>  net/6lowpan/iphc.c            | 2 +-
>  net/bluetooth/6lowpan.c       | 4 ++--
>  net/ieee802154/6lowpan_rtnl.c | 5 ++---
>  4 files changed, 6 insertions(+), 7 deletions(-)
> 

I don't test it yet, but you need to add a Signed-off-by: ...

You can create this with -s parameter while git format-patch.

Then I will test it.

- Alex

------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Linux-zigbee-devel mailing list
Linux-zigbee-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-zigbee-devel
