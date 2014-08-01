Return-Path: <linux-zigbee-devel-bounces@lists.sourceforge.net>
Date: Fri, 1 Aug 2014 13:37:15 +0200
From: Alexander Aring <alex.aring@gmail.com>
Message-ID: <20140801113713.GB12179@omega>
References: <53DB6FAF.2090707@xsilon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53DB6FAF.2090707@xsilon.com>
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
Subject: Re: [Linux-zigbee-devel] [PATCH v2 bluetooth-next] 6lowpan: Remove
 ununsed dev parameter from skb_delivery_cb callback.
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, linux-zigbee-devel@lists.sourceforge.net
List-ID: <linux-wpan.vger.kernel.org>

On Fri, Aug 01, 2014 at 11:45:03AM +0100, Martin Townsend wrote:
> This parameter is never used by any function implementing this callback.
> 
> Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>

Acked-by: Alexander Aring <alex.aring@gmail.com>

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
