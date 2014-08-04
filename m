Return-Path: <linux-zigbee-devel-bounces@lists.sourceforge.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20140804094815.GA16774@omega>
Date: Mon, 4 Aug 2014 08:35:48 -0700
Message-Id: <215A7DE1-74A1-4454-8DDF-98E960F7260D@holtmann.org>
References: <53DF4B10.7000209@xsilon.com> <20140804090403.GB15334@omega>
	<53DF4F7B.4090307@xsilon.com> <20140804093630.GD15334@omega>
	<20140804094147.GE15334@omega> <20140804094815.GA16774@omega>
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
Subject: Re: [Linux-zigbee-devel] [PATCH v3 bluetooth-next] Simplify lowpan
	receive path so skb is freed in, lowpan_rcv when dropped.
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, linux-zigbee-devel@lists.sourceforge.net, BlueZ development <linux-bluetooth@vger.kernel.org>
List-ID: <linux-wpan.vger.kernel.org>

Hi Alex,

>>>> The changes were made to a clone of bluetooth-next, do I have the right repository?
>>>> 
>>>> martin@martin-HP-ProDesk-490-G1-MT:~/workspace/bluetooth-next$ git ls-remote
>>>> From git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
>>>> 
>>> yes, but maybe it's a little bit outdated. Try to update it, on top of
>>> git log should be the patches:
>>> 
>>> http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/log/
>>> 
>> 
>> I think I know now why it fails. This patch depends on your previous patch
>> ("6lowpan: Remove ununsed dev parameter from skb_delivery_cb
>> callback."), otherwise I get merge conflicts.
>> 
>> Normally you need to send this in a series of patches to avoid something
>> like this. Now you need to wait until your patch ("6lowpan: Remove
>> ununsed dev parameter from skb_delivery_cb callback.") go into the
>> bluetooth-next tree.
>> 
> 
> Or write in the patch file under the "---" lines:
> 
> "This patch depends on..." if Marcel can deal with this kind of
> dependency notification.
> 
> Otherwise nobody knows what's going on now and want to apply it on
> bluetooth-next, like me...
> 
> 
> btw. lines after "---" will be ignored by applying.

so I am fine either way. You can mention this in the section after --- or you just send a patch set that is versioned [PATCH x/y].

Just right now I am delaying applying net/6lowpan/ patches until John, Dave and I have resolved the merge conflicts for getting the current patches into net-next. After that I will start actively applying these patches.

Regards

Marcel


------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
_______________________________________________
Linux-zigbee-devel mailing list
Linux-zigbee-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-zigbee-devel
